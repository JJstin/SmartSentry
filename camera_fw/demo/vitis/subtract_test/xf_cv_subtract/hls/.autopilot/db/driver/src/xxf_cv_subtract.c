// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.1 (64-bit)
// Tool Version Limit: 2024.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xxf_cv_subtract.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XXf_cv_subtract_CfgInitialize(XXf_cv_subtract *InstancePtr, XXf_cv_subtract_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XXf_cv_subtract_Start(XXf_cv_subtract *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL) & 0x80;
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XXf_cv_subtract_IsDone(XXf_cv_subtract *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XXf_cv_subtract_IsIdle(XXf_cv_subtract *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XXf_cv_subtract_IsReady(XXf_cv_subtract *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XXf_cv_subtract_EnableAutoRestart(XXf_cv_subtract *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XXf_cv_subtract_DisableAutoRestart(XXf_cv_subtract *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_AP_CTRL, 0);
}

void XXf_cv_subtract_Set_img_in1(XXf_cv_subtract *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN1_DATA, (u32)(Data));
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN1_DATA + 4, (u32)(Data >> 32));
}

u64 XXf_cv_subtract_Get_img_in1(XXf_cv_subtract *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN1_DATA);
    Data += (u64)XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN1_DATA + 4) << 32;
    return Data;
}

void XXf_cv_subtract_Set_img_in2(XXf_cv_subtract *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN2_DATA, (u32)(Data));
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN2_DATA + 4, (u32)(Data >> 32));
}

u64 XXf_cv_subtract_Get_img_in2(XXf_cv_subtract *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN2_DATA);
    Data += (u64)XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_IN2_DATA + 4) << 32;
    return Data;
}

void XXf_cv_subtract_Set_img_out(XXf_cv_subtract *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_OUT_DATA, (u32)(Data));
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_OUT_DATA + 4, (u32)(Data >> 32));
}

u64 XXf_cv_subtract_Get_img_out(XXf_cv_subtract *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_OUT_DATA);
    Data += (u64)XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IMG_OUT_DATA + 4) << 32;
    return Data;
}

void XXf_cv_subtract_InterruptGlobalEnable(XXf_cv_subtract *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_GIE, 1);
}

void XXf_cv_subtract_InterruptGlobalDisable(XXf_cv_subtract *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_GIE, 0);
}

void XXf_cv_subtract_InterruptEnable(XXf_cv_subtract *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IER);
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IER, Register | Mask);
}

void XXf_cv_subtract_InterruptDisable(XXf_cv_subtract *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IER);
    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IER, Register & (~Mask));
}

void XXf_cv_subtract_InterruptClear(XXf_cv_subtract *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XXf_cv_subtract_WriteReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_ISR, Mask);
}

u32 XXf_cv_subtract_InterruptGetEnabled(XXf_cv_subtract *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_IER);
}

u32 XXf_cv_subtract_InterruptGetStatus(XXf_cv_subtract *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XXf_cv_subtract_ReadReg(InstancePtr->Control_BaseAddress, XXF_CV_SUBTRACT_CONTROL_ADDR_ISR);
}

