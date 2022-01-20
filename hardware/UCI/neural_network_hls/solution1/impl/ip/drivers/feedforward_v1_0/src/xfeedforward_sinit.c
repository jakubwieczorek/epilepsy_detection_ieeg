// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xfeedforward.h"

extern XFeedforward_Config XFeedforward_ConfigTable[];

XFeedforward_Config *XFeedforward_LookupConfig(u16 DeviceId) {
	XFeedforward_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFEEDFORWARD_NUM_INSTANCES; Index++) {
		if (XFeedforward_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFeedforward_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFeedforward_Initialize(XFeedforward *InstancePtr, u16 DeviceId) {
	XFeedforward_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFeedforward_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFeedforward_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

