vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_8
vlib riviera/processing_system7_vip_v1_0_10
vlib riviera/blk_mem_gen_v8_4_4
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_register_slice_v2_1_22
vlib riviera/fifo_generator_v13_2_5
vlib riviera/axi_data_fifo_v2_1_21
vlib riviera/axi_crossbar_v2_1_23
vlib riviera/xbip_utils_v3_0_10
vlib riviera/axi_utils_v2_0_6
vlib riviera/xbip_pipe_v3_0_6
vlib riviera/xbip_dsp48_wrapper_v3_0_4
vlib riviera/xbip_dsp48_addsub_v3_0_6
vlib riviera/xbip_dsp48_multadd_v3_0_6
vlib riviera/xbip_bram18k_v3_0_6
vlib riviera/mult_gen_v12_0_16
vlib riviera/floating_point_v7_1_11
vlib riviera/axi_bram_ctrl_v4_1_4
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_13
vlib riviera/axi_protocol_converter_v2_1_22

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_8 riviera/axi_vip_v1_1_8
vmap processing_system7_vip_v1_0_10 riviera/processing_system7_vip_v1_0_10
vmap blk_mem_gen_v8_4_4 riviera/blk_mem_gen_v8_4_4
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_22 riviera/axi_register_slice_v2_1_22
vmap fifo_generator_v13_2_5 riviera/fifo_generator_v13_2_5
vmap axi_data_fifo_v2_1_21 riviera/axi_data_fifo_v2_1_21
vmap axi_crossbar_v2_1_23 riviera/axi_crossbar_v2_1_23
vmap xbip_utils_v3_0_10 riviera/xbip_utils_v3_0_10
vmap axi_utils_v2_0_6 riviera/axi_utils_v2_0_6
vmap xbip_pipe_v3_0_6 riviera/xbip_pipe_v3_0_6
vmap xbip_dsp48_wrapper_v3_0_4 riviera/xbip_dsp48_wrapper_v3_0_4
vmap xbip_dsp48_addsub_v3_0_6 riviera/xbip_dsp48_addsub_v3_0_6
vmap xbip_dsp48_multadd_v3_0_6 riviera/xbip_dsp48_multadd_v3_0_6
vmap xbip_bram18k_v3_0_6 riviera/xbip_bram18k_v3_0_6
vmap mult_gen_v12_0_16 riviera/mult_gen_v12_0_16
vmap floating_point_v7_1_11 riviera/floating_point_v7_1_11
vmap axi_bram_ctrl_v4_1_4 riviera/axi_bram_ctrl_v4_1_4
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13
vmap axi_protocol_converter_v2_1_22 riviera/axi_protocol_converter_v2_1_22

vlog -work xilinx_vip  -sv2k12 "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_8  -sv2k12 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/94c3/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_10  -sv2k12 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \

vlog -work blk_mem_gen_v8_4_4  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_0/sim/design_1_blk_mem_gen_0_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_22  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/af2c/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_5  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_21  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/54c0/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_23  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/bc0a/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \

vcom -work xbip_utils_v3_0_10 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/d117/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_6 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/1971/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_6 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/7468/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_4 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/cdbf/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_addsub_v3_0_6 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/910d/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_multadd_v3_0_6 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/b0ac/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \

vcom -work xbip_bram18k_v3_0_6 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/d367/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_16 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ce84/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work floating_point_v7_1_11 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/b0c0/hdl/floating_point_v7_1_rfs.vhd" \

vlog -work floating_point_v7_1_11  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/b0c0/hdl/floating_point_v7_1_rfs.v" \

vcom -work xil_defaultlib -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_b1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_CTRL_BUS_s_axi.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_fadd_32ns_32ns_32_5_full_dsp_1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_fcmp_32ns_32ns_1_2_no_dsp_1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_fdiv_32ns_32ns_32_16_no_dsp_1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_fexp_32ns_32ns_32_9_full_dsp_1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_fmul_32ns_32ns_32_4_max_dsp_1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_l1y.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_w1.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_w2_0.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward_wy_sum.vhd" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/vhdl/feedforward.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/ip/feedforward_ap_fadd_3_full_dsp_32.v" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/ip/feedforward_ap_fexp_7_full_dsp_32.v" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/ip/feedforward_ap_fdiv_14_no_dsp_32.v" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/ip/feedforward_ap_fmul_2_max_dsp_32.v" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/e912/hdl/ip/feedforward_ap_fcmp_0_no_dsp_32.v" \
"../../../bd/design_1/ip/design_1_feedforward_0_0/sim/design_1_feedforward_0_0.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_1/sim/design_1_blk_mem_gen_0_1.v" \

vcom -work axi_bram_ctrl_v4_1_4 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/c9f0/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_0/sim/design_1_axi_bram_ctrl_0_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_1/sim/design_1_axi_bram_ctrl_0_1.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_rst_ps7_0_100M_0/sim/design_1_rst_ps7_0_100M_0.vhd" \

vlog -work axi_protocol_converter_v2_1_22  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/5cee/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../neural_network_vivado.gen/sources_1/bd/design_1/ipshared/34f8/hdl" "+incdir+/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

