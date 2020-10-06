onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib BUFFER_32K_28_opt

do {wave.do}

view wave
view structure
view signals

do {BUFFER_32K_28.udo}

run -all

quit -force
