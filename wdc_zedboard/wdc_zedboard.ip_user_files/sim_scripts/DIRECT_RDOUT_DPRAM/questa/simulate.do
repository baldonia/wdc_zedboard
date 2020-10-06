onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DIRECT_RDOUT_DPRAM_opt

do {wave.do}

view wave
view structure
view signals

do {DIRECT_RDOUT_DPRAM.udo}

run -all

quit -force
