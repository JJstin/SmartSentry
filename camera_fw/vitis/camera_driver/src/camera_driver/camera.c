#include "camera.h"
#include "xiic.h"
#include "xiic_l.h"
#include "xgpio.h"
#include "xstatus.h"
#include "xparameters.h"
#include <stdio.h>
#include <stdlib.h>

#define CAMERA_I2C_ADDR 0x3CU
#define CAMERA_GPIO_CHANNEL 1U
#define GPIO_DIRECTION_MASK 0b1111111111U
#define TOGGLE_DELAY 1000000U

#define PIXEL_MASK 0xFFU
#define HS_MASK 0x100U
#define VS_MASK 0x200U

static XIic i2cInst;
static XGpio gpioInstInput;
static XGpio gpioInstOutput;
static u8* buffer;

u8 cameraInit(){
    // Init i2c
    XIic_Config *ConfigPtr = XIic_LookupConfig(XPAR_AXI_IIC_0_BASEADDR);

    if (ConfigPtr == NULL) {
        return XST_FAILURE;
    }

	XIic_CfgInitialize(&i2cInst, ConfigPtr,
					    ConfigPtr->BaseAddress);
	
    XIic_SetAddress(&i2cInst, XII_ADDR_TO_SEND_TYPE, CAMERA_I2C_ADDR);
    
    // Init GPIO
    XGpio_Initialize(&gpioInstInput, XPAR_AXI_GPIO_0_BASEADDR);
    XGpio_Initialize(&gpioInstOutput, XPAR_AXI_GPIO_1_BASEADDR);

    XGpio_SetDataDirection(&gpioInstInput,CAMERA_GPIO_CHANNEL, GPIO_DIRECTION_MASK);
    XGpio_SetDataDirection(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0);
    
    // Malloc buffer

    buffer = malloc(6220800);
    if(buffer == NULL){
        printf("malloc failed\r\n");
    }
    return XST_SUCCESS;
}

u8 cameraWrite(u16 address, u8 value){
    u8 twoByte[2];
    twoByte[0] = (address >> 8) & 0xFF;
    twoByte[1] = (address) & 0xFF;

    XIic_Send(i2cInst.BaseAddress, CAMERA_I2C_ADDR, twoByte,2,XIIC_STOP);
    u8 byte = value;
    return XIic_Send(i2cInst.BaseAddress, CAMERA_I2C_ADDR, &byte,1,XIIC_STOP);
}

u8 cameraRead(u16 address, u8* buff){
    if(buff == NULL){
        return XST_FAILURE;
    }

    u8 twoByte[2];
    twoByte[0] = (address >> 8) & 0xFF;
    twoByte[1] = (address) & 0xFF;
    XIic_Send(i2cInst.BaseAddress, CAMERA_I2C_ADDR, twoByte,2,XIIC_STOP);
    return XIic_Recv(i2cInst.BaseAddress, CAMERA_I2C_ADDR, buff,1,XIIC_STOP);
}

u8 readHS(void){
    return XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & HS_MASK;
}

u8 readVS(void){
    return XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & VS_MASK;
}

u8 cameraReadPixel(void){
    return XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & PIXEL_MASK;
}

u8 togglePS(void){
    XGpio_DiscreteWrite(&gpioInstInput, CAMERA_GPIO_CHANNEL, 1);

    XGpio_DiscreteWrite(&gpioInstInput, CAMERA_GPIO_CHANNEL, 0);
    return XST_SUCCESS;
}

// u8 capture(void){

// }