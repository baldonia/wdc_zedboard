onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+DIG0_MMCM -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.DIG0_MMCM xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {DIG0_MMCM.udo}

run -all

endsim

quit -force
