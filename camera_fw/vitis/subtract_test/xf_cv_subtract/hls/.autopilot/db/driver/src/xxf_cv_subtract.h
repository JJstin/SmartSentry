// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XXF_CV_SUBTRACT_H
#define XXF_CV_SUBTRACT_H

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
#include "xxf_cv_subtract_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XXf_cv_subtract_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XXf_cv_subtract;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XXf_cv_subtract_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XXf_cv_subtract_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XXf_cv_subtract_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XXf_cv_subtract_ReadReg(BaseAddress, RegOffset) \
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
#ifdef SDT
int XXf_cv_subtract_Initialize(XXf_cv_subtract *InstancePtr, UINTPTR BaseAddress);
XXf_cv_subtract_Config* XXf_cv_subtract_LookupConfig(UINTPTR BaseAddress);
#else
int XXf_cv_subtract_Initialize(XXf_cv_subtract *InstancePtr, u16 DeviceId);
XXf_cv_subtract_Config* XXf_cv_subtract_LookupConfig(u16 DeviceId);
#endif
int XXf_cv_subtract_CfgInitialize(XXf_cv_subtract *InstancePtr, XXf_cv_subtract_Config *ConfigPtr);
#else
int XXf_cv_subtract_Initialize(XXf_cv_subtract *InstancePtr, const char* InstanceName);
int XXf_cv_subtract_Release(XXf_cv_subtract *InstancePtr);
#endif

void XXf_cv_subtract_Start(XXf_cv_subtract *InstancePtr);
u32 XXf_cv_subtract_IsDone(XXf_cv_subtract *InstancePtr);
u32 XXf_cv_subtract_IsIdle(XXf_cv_subtract *InstancePtr);
u32 XXf_cv_subtract_IsReady(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_EnableAutoRestart(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_DisableAutoRestart(XXf_cv_subtract *InstancePtr);

void XXf_cv_subtract_Set_img_in1(XXf_cv_subtract *InstancePtr, u64 Data);
u64 XXf_cv_subtract_Get_img_in1(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_Set_img_in2(XXf_cv_subtract *InstancePtr, u64 Data);
u64 XXf_cv_subtract_Get_img_in2(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_Set_img_out(XXf_cv_subtract *InstancePtr, u64 Data);
u64 XXf_cv_subtract_Get_img_out(XXf_cv_subtract *InstancePtr);

void XXf_cv_subtract_InterruptGlobalEnable(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_InterruptGlobalDisable(XXf_cv_subtract *InstancePtr);
void XXf_cv_subtract_InterruptEnable(XXf_cv_subtract *InstancePtr, u32 Mask);
void XXf_cv_subtract_InterruptDisable(XXf_cv_subtract *InstancePtr, u32 Mask);
void XXf_cv_subtract_InterruptClear(XXf_cv_subtract *InstancePtr, u32 Mask);
u32 XXf_cv_subtract_InterruptGetEnabled(XXf_cv_subtract *InstancePtr);
u32 XXf_cv_subtract_InterruptGetStatus(XXf_cv_subtract *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
