############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project neural_network_hls_ar
set_top feedforward
add_files neural_network_hls_ar/w2.h
add_files neural_network_hls_ar/w1.h
add_files neural_network_hls_ar/feedforward.h
add_files neural_network_hls_ar/feedforward.cpp
add_files neural_network_hls_ar/b2.h
add_files neural_network_hls_ar/b1.h
add_files -tb neural_network_hls_ar/val_labels.h -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls_ar/val_data.h -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls_ar/test_labels.h -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls_ar/test_data.h -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls_ar/main.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls_ar/expected_result2.txt -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -format ip_catalog -rtl vhdl
set_clock_uncertainty 2
source "./neural_network_hls_ar/solution1/directives.tcl"
csim_design
csynth_design
cosim_design -rtl vhdl
export_design -rtl vhdl -format ip_catalog
