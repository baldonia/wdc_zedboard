onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+DIST_BUFFER_64_28 -L xil_defaultlib -L xpm -L dist_mem_gen_v8_0_13 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.DIST_BUFFER_64_28 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {DIST_BUFFER_64_28.udo}

run -all

endsim

quit -force
