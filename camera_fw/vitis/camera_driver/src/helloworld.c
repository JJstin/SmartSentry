/******************************************************************************
* Copyright (C) 2006 - 2021 Xilinx, Inc.  All rights reserved.
* Copyright (c) 2022 - 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

/*****************************************************************************/
/**
* @file xiic_tempsensor_example.c
*
* This file contains an interrupt based design example which uses the Xilinx
* IIC device and driver to exercise the temperature sensor on the ML300 board.
* This example only performs read operations (receive) from the IIC temperature
* sensor of the platform.
*
* The XIic_MasterRecv() API is used to receive the data.
*
* This example assumes that there is an interrupt controller in the hardware
* system and the IIC device is connected to the interrupt controller.
*
* @note
*
* 7-bit addressing is used to access the tempsensor.
*
* None
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date	 Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a jhl  09/10/03 Created
* 1.00a sv   05/09/05 Minor changes to comply to Doxygen and coding guidelines
* 3.4   ms   01/23/17 Added xil_printf statement in main function to
*                     ensure that "Successfully ran" and "Failed" strings
*                     are available in all examples. This is a fix for
*                     CR-965028.
* 3.10  gm   07/09/23 Added SDT support.
* </pre>
*
*****************************************************************************/

/***************************** Include Files ********************************/

#include "xparameters.h"
#include "xiic.h"
#include <stdio.h>
#include <xiic_l.h>
#ifndef SDT
#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#else
#include "xscugic.h"
#endif
#endif
#include "xil_exception.h"
#include "xil_printf.h"
#ifdef SDT
#include "xinterrupt_wrap.h"
#endif

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */

#define	XIIC_BASEADDRESS	XPAR_XIIC_0_BASEADDR

/*
 * The following constant defines the address of the IIC
 * temperature sensor device on the IIC bus. Note that since
 * the address is only 7 bits, this  constant is the address divided by 2.
 */
#define TEMP_SENSOR_ADDRESS	0x3C /* The actual address is 0x30 */


/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ****************************/


int CameraTest(UINTPTR BaseAddress, u8 TempSensorAddress,
		      u8 *TemperaturePtr);


/************************** Variable Definitions **************************/

XIic Iic;		  /* The instance of the IIC device */


int main(void)
{
	int Status;
	u8 TemperaturePtr;

	/*
	 * Call the TempSensorExample.
	 */
	Status =  CameraTest(XIIC_BASEADDRESS, TEMP_SENSOR_ADDRESS,
				    &TemperaturePtr);
	if (Status != XST_SUCCESS) {
		xil_printf("IIC tempsensor Example Failed\r\n");
		return XST_FAILURE;
	}

	xil_printf("Successfully ran IIC tempsensor Example\r\n");
	return XST_SUCCESS;

}


int CameraTest(UINTPTR BaseAddress, u8 TempSensorAddress, u8 *TemperaturePtr)
{

	XIic_Config *ConfigPtr = XIic_LookupConfig(BaseAddress);

    if (ConfigPtr == NULL) {
        return XST_FAILURE;
    }

	XIic_CfgInitialize(&Iic, ConfigPtr,
					    ConfigPtr->BaseAddress);



	
    XIic_SetAddress(&Iic, XII_ADDR_TO_SEND_TYPE, TempSensorAddress);
	


    u8 upperAddr[] = {0x30, 0x0A};
    u8 lowerAddr[] = {0x30, 0x0B};

    //XIic_Start(&Iic);
    XIic_Send(Iic.BaseAddress, TempSensorAddress, upperAddr,2,XIIC_STOP);
	
    u8 buffer;
	(void)XIic_Recv(Iic.BaseAddress, TempSensorAddress, &buffer,1, XIIC_STOP);

    xil_printf("0x%x\r\n", buffer);

    XIic_Send(Iic.BaseAddress, TempSensorAddress, lowerAddr,2,XIIC_STOP);
	
	(void)XIic_Recv(Iic.BaseAddress, TempSensorAddress, &buffer,1, XIIC_STOP);
    xil_printf("0x%x\r\n", buffer);

    return XST_SUCCESS;

}

