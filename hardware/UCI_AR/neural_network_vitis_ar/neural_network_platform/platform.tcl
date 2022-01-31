# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_vitis_ar/neural_network_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_vitis_ar/neural_network_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {neural_network_platform}\
-hw {/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_vivado_ar/design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI_AR/neural_network_vitis_ar}

platform write
platform generate -domains 
platform active {neural_network_platform}
platform generate
platform active {neural_network_platform}
platform generate
