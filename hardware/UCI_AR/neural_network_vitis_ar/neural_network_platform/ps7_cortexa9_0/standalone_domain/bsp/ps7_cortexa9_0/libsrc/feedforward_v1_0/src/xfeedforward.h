// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XFEEDFORWARD_H
#define XFEEDFORWARD_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xfeedforward_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Ctrl_bus_BaseAddress;
} XFeedforward_Config;
#endif

typedef struct {
    u64 Ctrl_bus_BaseAddress;
    u32 IsReady;
} XFeedforward;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFeedforward_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFeedforward_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFeedforward_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFeedforward_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XFeedforward_Initialize(XFeedforward *InstancePtr, u16 DeviceId);
XFeedforward_Config* XFeedforward_LookupConfig(u16 DeviceId);
int XFeedforward_CfgInitialize(XFeedforward *InstancePtr, XFeedforward_Config *ConfigPtr);
#else
int XFeedforward_Initialize(XFeedforward *InstancePtr, const char* InstanceName);
int XFeedforward_Release(XFeedforward *InstancePtr);
#endif

void XFeedforward_Start(XFeedforward *InstancePtr);
u32 XFeedforward_IsDone(XFeedforward *InstancePtr);
u32 XFeedforward_IsIdle(XFeedforward *InstancePtr);
u32 XFeedforward_IsReady(XFeedforward *InstancePtr);
void XFeedforward_EnableAutoRestart(XFeedforward *InstancePtr);
void XFeedforward_DisableAutoRestart(XFeedforward *InstancePtr);


void XFeedforward_InterruptGlobalEnable(XFeedforward *InstancePtr);
void XFeedforward_InterruptGlobalDisable(XFeedforward *InstancePtr);
void XFeedforward_InterruptEnable(XFeedforward *InstancePtr, u32 Mask);
void XFeedforward_InterruptDisable(XFeedforward *InstancePtr, u32 Mask);
void XFeedforward_InterruptClear(XFeedforward *InstancePtr, u32 Mask);
u32 XFeedforward_InterruptGetEnabled(XFeedforward *InstancePtr);
u32 XFeedforward_InterruptGetStatus(XFeedforward *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
