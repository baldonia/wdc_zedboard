onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib SCRATCH_DPRAM_opt

do {wave.do}

view wave
view structure
view signals

do {SCRATCH_DPRAM.udo}

run -all

quit -force
