onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib FIFO_2048_32_opt

do {wave.do}

view wave
view structure
view signals

do {FIFO_2048_32.udo}

run -all

quit -force
