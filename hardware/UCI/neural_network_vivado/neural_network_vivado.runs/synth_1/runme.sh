#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/home/jakub/apps/Xilinx/Vitis/2020.2/bin:/home/jakub/apps/Xilinx/Vivado/2020.2/ids_lite/ISE/bin/lin64:/home/jakub/apps/Xilinx/Vivado/2020.2/bin
else
  PATH=/home/jakub/apps/Xilinx/Vitis/2020.2/bin:/home/jakub/apps/Xilinx/Vivado/2020.2/ids_lite/ISE/bin/lin64:/home/jakub/apps/Xilinx/Vivado/2020.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/jakub/Documents/PyCharmProjects/epilepsy_detection_ieeg/hardware/UCI/neural_network_vivado/neural_network_vivado.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log design_1_wrapper.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source design_1_wrapper.tcl
