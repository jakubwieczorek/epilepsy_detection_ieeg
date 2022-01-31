-makelib ies_lib/xilinx_vip -sv \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib ies_lib/xpm -sv \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/jakub/apps/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/sim/design_1.vhd" \
-endlib
-makelib ies_lib/xbip_utils_v3_0_10 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/d117/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/axi_utils_v2_0_6 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/1971/hdl/axi_utils_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xbip_pipe_v3_0_6 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/7468/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xbip_dsp48_wrapper_v3_0_4 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/cdbf/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xbip_dsp48_addsub_v3_0_6 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/910d/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xbip_dsp48_multadd_v3_0_6 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/b0ac/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xbip_bram18k_v3_0_6 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/d367/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/mult_gen_v12_0_16 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/ce84/hdl/mult_gen_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/floating_point_v7_1_11 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/b0c0/hdl/floating_point_v7_1_rfs.vhd" \
-endlib
-makelib ies_lib/floating_point_v7_1_11 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/b0c0/hdl/floating_point_v7_1_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_b1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_CTRL_BUS_s_axi.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_fadd_32ns_32ns_32_5_full_dsp_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_fcmp_32ns_32ns_1_2_no_dsp_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_fdiv_32ns_32ns_32_16_no_dsp_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_fexp_32ns_32ns_32_9_full_dsp_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_fmul_32ns_32ns_32_4_max_dsp_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_l1y.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_0.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_1.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_2.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_3.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_4.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_5.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_6.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_7.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_8.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_9.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_10.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_11.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_12.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_13.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_14.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w1_15.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_w2_0.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward_wy_sum.vhd" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/vhdl/feedforward.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/ip/feedforward_ap_fadd_3_full_dsp_32.v" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/ip/feedforward_ap_fexp_7_full_dsp_32.v" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/ip/feedforward_ap_fdiv_14_no_dsp_32.v" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/ip/feedforward_ap_fmul_2_max_dsp_32.v" \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/595b/hdl/ip/feedforward_ap_fcmp_0_no_dsp_32.v" \
  "../../../bd/design_1/ip/design_1_feedforward_0_0/sim/design_1_feedforward_0_0.v" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_4 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_blk_mem_gen_0_0/sim/design_1_blk_mem_gen_0_0.v" \
  "../../../bd/design_1/ip/design_1_blk_mem_gen_0_1/sim/design_1_blk_mem_gen_0_1.v" \
-endlib
-makelib ies_lib/axi_bram_ctrl_v4_1_4 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/c9f0/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_0/sim/design_1_axi_bram_ctrl_0_0.vhd" \
  "../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_1/sim/design_1_axi_bram_ctrl_0_1.vhd" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_vip_v1_1_8 -sv \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/94c3/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_10 -sv \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/34f8/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_22 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/af2c/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_5 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_21 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/54c0/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_crossbar_v2_1_23 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/bc0a/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_pkg_v1_0_2 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/axi_timer_v2_0_24 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/70d6/hdl/axi_timer_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_axi_timer_0_0/sim/design_1_axi_timer_0_0.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_13 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_rst_ps7_0_50M_0/sim/design_1_rst_ps7_0_50M_0.vhd" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_22 \
  "../../../../neural_network_vivado_ar.gen/sources_1/bd/design_1/ipshared/5cee/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_auto_pc_2/sim/design_1_auto_pc_2.v" \
  "../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
  "../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

