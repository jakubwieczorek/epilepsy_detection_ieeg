############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project neural_network_hls
set_top feedforward
add_files neural_network_hls/feedforward.cpp
add_files -tb neural_network_hls/main.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
add_files -tb neural_network_hls/expected_result.txt -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -format ip_catalog -rtl vhdl
set_clock_uncertainty 2
source "./neural_network_hls/solution1/directives.tcl"
csim_design -clean -O
csynth_design
cosim_design -rtl vhdl
export_design -rtl vhdl -format ip_catalog
