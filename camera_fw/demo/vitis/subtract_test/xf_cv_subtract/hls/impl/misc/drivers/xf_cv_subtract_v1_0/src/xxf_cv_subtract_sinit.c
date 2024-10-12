// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xxf_cv_subtract.h"

extern XXf_cv_subtract_Config XXf_cv_subtract_ConfigTable[];

#ifdef SDT
XXf_cv_subtract_Config *XXf_cv_subtract_LookupConfig(UINTPTR BaseAddress) {
	XXf_cv_subtract_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XXf_cv_subtract_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XXf_cv_subtract_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XXf_cv_subtract_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XXf_cv_subtract_Initialize(XXf_cv_subtract *InstancePtr, UINTPTR BaseAddress) {
	XXf_cv_subtract_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XXf_cv_subtract_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XXf_cv_subtract_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XXf_cv_subtract_Config *XXf_cv_subtract_LookupConfig(u16 DeviceId) {
	XXf_cv_subtract_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XXF_CV_SUBTRACT_NUM_INSTANCES; Index++) {
		if (XXf_cv_subtract_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XXf_cv_subtract_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XXf_cv_subtract_Initialize(XXf_cv_subtract *InstancePtr, u16 DeviceId) {
	XXf_cv_subtract_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XXf_cv_subtract_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XXf_cv_subtract_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

