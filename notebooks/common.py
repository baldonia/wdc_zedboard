import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt

colors = plt.rcParams["axes.prop_cycle"].by_key()["color"]


def load_data(fname, wfm_dir="../software/waveforms"):
    with np.load(f"{wfm_dir}/{fname}", allow_pickle=True) as f:
        return f["a"]


def build_combined_wfm(wfms):
    n_samples = len(wfms[0]["samples"])

    combined_samples = np.empty(2 * n_samples, np.uint16)
    combined_samples[::2] = wfms[1]["samples"]
    combined_samples[1::2] = wfms[0]["samples"]
    combined_wfm = dict(chan_num="combined", samples=combined_samples)

    return combined_wfm


def plot_wfm(wfm, ax, colors=colors, xlim=None, show_stats=True):
    chan_num = wfm["chan_num"]

    if chan_num == "combined":
        title = "interleaved"
        samps = wfm["samples"]
        n_samps = len(samps)
        ax.plot(np.arange(len(samps)) / 2, samps, "k--")
        ax.plot(samps[::2], "o", color=colors[1])
        ax.plot(np.arange(int(n_samps / 2)) + 0.5, samps[1::2], "o", color=colors[0])
        ax.set_xlabel("sample number")
    else:
        color = colors[chan_num]
        title = f"channel {chan_num}"
        ax.plot(wfm["samples"], "-", color=color)

    if show_stats:
        mean = np.average(wfm["samples"])
        std = np.std(wfm["samples"])
        ax.set_title(f"{title}, mean: {mean:.2f}, std: {std:.2f}")
    else:
        ax.set_title(title)
        
    ax.set_ylabel("ADU")
    if xlim is not None:
        ax.set_xlim(*xlim)


def plot_wfms(wfms, n_samples=None, xlim=None, show_stats=True):
    if n_samples is None:
        n_samples = len(wfms[0]["samples"])

    wfms = [wfm.copy() for wfm in wfms]
    for wfm in wfms:
        wfm["samples"] = wfm["samples"][:n_samples]

    combined_wfm = build_combined_wfm(wfms)

    fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(12, 9))
    plt.subplots_adjust(hspace=0.3)
    for chan, ax in zip([0, 1, "combined"], axes.flat):
        wfm = wfms[chan] if chan != "combined" else combined_wfm
        plot_wfm(wfm, ax, xlim=xlim, show_stats=show_stats)


#
# Template fit related
#


def get_template_fit_func(templ):
    def f(t, s, t0, P):
        return s * templ(t - t0) + P

    return f


def template_fit(wfm, template, fit_range=(-5, 5), n_baseline=100):
    fit_func = get_template_fit_func(template)

    try:
        samples = wfm["samples"]
    except IndexError:
        samples = wfm

    sample_times = np.arange(len(samples))

    peak = np.argmax(samples)
    fit_range = (sample_times >= peak + fit_range[0]) & (
        sample_times <= peak + fit_range[1]
    )

    baseline_guess = np.average(samples[:100])

    tweaks = [0, -1, 1]
    for tweak in tweaks:
        try:
            fit_res = curve_fit(
                fit_func,
                sample_times[fit_range],
                samples[fit_range],
                [1, peak + tweak, baseline_guess],
            )
            break
        except RuntimeError:
            if tweak == tweaks[-1]:
                raise

    return fit_res, fit_range


def plot_template_fit(wfm, templ_spline, fit_out, color, ax, legend=True):
    fit_p, fit_range = fit_out

    samps = wfm["samples"][fit_range]
    sample_nums = np.arange(len(wfm["samples"]))[fit_range]
    t_pts = np.linspace(sample_nums[0] - 1, sample_nums[-1] + 1, 1000)
    if wfm["chan_num"] == "combined":
        title = "interleaved"
        plot_t_pts = t_pts / 2
        plot_s_pts = sample_nums / 2
    else:
        title = f'channel {wfm["chan_num"]}'
        plot_t_pts = t_pts
        plot_s_pts = sample_nums

    ax.plot(plot_s_pts, samps, "o", color=color, label="samples")
    ax.plot(
        plot_t_pts,
        get_template_fit_func(templ_spline)(t_pts, *fit_p[0]),
        "--",
        color=color,
        label="template fit",
    )

    ax.set_title(title)
    ax.set_ylabel("ADU")
    if legend:
        ax.legend()


#
# CFD-related
#


def cfd(waveform, delay, scale, sample_time=2, n_baseline=100):
    waveform = waveform - np.average(waveform[:n_baseline])

    delayed = np.empty_like(waveform)
    delayed[delay:] = waveform[:-delay]
    delayed[:delay] = 0
    scaled_delayed = -1 * scale * delayed

    mixed = scaled_delayed + waveform

    # find zero crossing
    neg = mixed <= 0
    prev_pos = np.roll(mixed, 1) > 0
    cross_pts = neg & prev_pos
    crossing_inds = np.arange(len(waveform))[cross_pts]

    #  larges crossing within one sample of the peak
    max_ind = np.argmax(waveform)

    crossing_inds = crossing_inds[np.abs(max_ind - crossing_inds) <= sample_time]
    # pick the crossing with the maximum associated waveform sample
    max_crossing_ind = np.argmax(waveform[crossing_inds - 1])
    right_ind = crossing_inds[max_crossing_ind]

    right = mixed[right_ind]
    left = mixed[right_ind - 1]

    zero_crossing = right_ind - 1 + left / (left - right)

    return scaled_delayed, mixed, zero_crossing


def apply_phase_correction(time, spline, phase_zero):
    time -= phase_zero
    integer = np.floor(time)
    fraction = time - integer
    return integer + spline(fraction)


def cfd_time_reco(wfm, cor_spline, cor_zero, delay=1, scale=1):
    _, _, raw_t = cfd(wfm, delay, scale)
    return apply_phase_correction(raw_t, cor_spline, cor_zero)


def make_cfd_plot(delay, scale, templ, ax):
    fine_xs = np.linspace(-5, 5, 1000)
    dx = fine_xs[1] - fine_xs[0]
    ind_delay = int(delay / dx)

    original = templ(fine_xs)

    scaled_delayed, mixed, zero_crossing = cfd(
        original, ind_delay, scale, sample_time=1 / dx
    )

    z_floor = int(np.floor(zero_crossing))
    rest = zero_crossing - z_floor
    zero_crossing = fine_xs[z_floor] + dx * rest

    ax.plot(fine_xs, original, label="original")
    ax.plot(fine_xs, scaled_delayed, label="delayed & scaled")
    ax.plot(fine_xs, mixed, label="combined")

    ax.axvline(zero_crossing, color="black", linestyle="--")
    ax.axhline(0, color="black")

    ax.set_xlabel("sample number")
    ax.set_ylabel("ADU")

    ax.set_xlim(-3, 5)

    ax.legend(bbox_to_anchor=(1, 1.2))
