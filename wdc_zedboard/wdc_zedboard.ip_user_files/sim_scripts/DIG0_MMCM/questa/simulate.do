onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DIG0_MMCM_opt

do {wave.do}

view wave
view structure
view signals

do {DIG0_MMCM.udo}

run -all

quit -force
