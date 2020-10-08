onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ADC_SELECT_IO_opt

do {wave.do}

view wave
view structure
view signals

do {ADC_SELECT_IO.udo}

run -all

quit -force
