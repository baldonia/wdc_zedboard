onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ADC_SELECT_IO -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ADC_SELECT_IO xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ADC_SELECT_IO.udo}

run -all

endsim

quit -force
