create_project prj -part xc7z020-clg400-1 -force
set_property target_language vhdl [current_project]
set vivado_ver [version -short]
set COE_DIR "../../syn/vhdl"
source "/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_hls_ar/solution1/syn/vhdl/feedforward_ap_fexp_7_full_dsp_32_ip.tcl"
source "/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_hls_ar/solution1/syn/vhdl/feedforward_ap_fadd_3_full_dsp_32_ip.tcl"
source "/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_hls_ar/solution1/syn/vhdl/feedforward_ap_fdiv_14_no_dsp_32_ip.tcl"
source "/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_hls_ar/solution1/syn/vhdl/feedforward_ap_fcmp_0_no_dsp_32_ip.tcl"
source "/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_hls_ar/solution1/syn/vhdl/feedforward_ap_fmul_2_max_dsp_32_ip.tcl"
