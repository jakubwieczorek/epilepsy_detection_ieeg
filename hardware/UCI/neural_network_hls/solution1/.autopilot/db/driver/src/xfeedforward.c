// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xfeedforward.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XFeedforward_CfgInitialize(XFeedforward *InstancePtr, XFeedforward_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_bus_BaseAddress = ConfigPtr->Ctrl_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XFeedforward_Start(XFeedforward *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL) & 0x80;
    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XFeedforward_IsDone(XFeedforward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XFeedforward_IsIdle(XFeedforward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XFeedforward_IsReady(XFeedforward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XFeedforward_EnableAutoRestart(XFeedforward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL, 0x80);
}

void XFeedforward_DisableAutoRestart(XFeedforward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_AP_CTRL, 0);
}

void XFeedforward_InterruptGlobalEnable(XFeedforward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_GIE, 1);
}

void XFeedforward_InterruptGlobalDisable(XFeedforward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_GIE, 0);
}

void XFeedforward_InterruptEnable(XFeedforward *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_IER);
    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_IER, Register | Mask);
}

void XFeedforward_InterruptDisable(XFeedforward *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_IER);
    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_IER, Register & (~Mask));
}

void XFeedforward_InterruptClear(XFeedforward *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFeedforward_WriteReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_ISR, Mask);
}

u32 XFeedforward_InterruptGetEnabled(XFeedforward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_IER);
}

u32 XFeedforward_InterruptGetStatus(XFeedforward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFeedforward_ReadReg(InstancePtr->Ctrl_bus_BaseAddress, XFEEDFORWARD_CTRL_BUS_ADDR_ISR);
}

