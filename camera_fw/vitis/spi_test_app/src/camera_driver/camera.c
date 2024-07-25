#include "camera.h"
#include "capture.h"
#include "config.h"

#include "xiic.h"
#include "xiic_l.h"
#include "xspi.h"
#include "xstatus.h"
#include "xparameters.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <xil_assert.h>
#include <xil_printf.h>
#include <xil_types.h>

// Arduchip Constants
#define MAX_FIFO_SIZE 0x7FFFFF  // 8MByte

// Sensor Timing Control Masks
#define HSYNC_ACTIVE_LOW_MASK (0x01U << 0)
#define VSYNC_ACTIVE_LOW_MASK (0x01U << 1)
#define PCLK_REVERSED_MASK (0x01U << 3)
// FIFO Control Masks
#define FIFO_CLEAR_CAPTURE_DONE_FLAG (0x01U << 0)
#define FIFO_START_CAPTURE (0x01U << 1)
#define FIFO_RESET_WRITE_PTR (0x01U << 4)
#define FIFO_RESET_READ_PTR (0x01U << 5)
// Sensor Control Masks
#define SENSOR_RESET_MASK (0x01U << 0)
#define SENSOR_STANDBY_MASK (0x01 << 1)
#define SENSOR_POWER_EN_MASK (0x01U << 2)
// Capture Status Masks
#define STATUS_VSYNC_MASK (0x01U << 0)
#define STATUS_CAPTURE_DONE_MASK (0x01 << 3)

// Arduchip masks
#define ARDUCHIP_WRITE_MASK 0x80
#define ARDUCAM_RESET_CPLD_MASK 0x80

// Arduchip Opcodes
#define OP_READ_TEST_REG 0x00
#define OP_READ_CAPTURE_CONTROL_REG 0x01
#define OP_READ_SENSOR_TIMING_CONTROL_REG 0x03
#define OP_READ_FIFO_CONTROL_REG 0x04
#define OP_READ_SENSOR_POWER_CONTROL_REG 0x06
#define OP_RESET_CPLD (0x07 | ARDUCHIP_WRITE_MASK)
#define OP_FIFO_BURST_READ 0x3C
#define OP_FIFO_READ 0x3D
#define OP_READ_FW_VERSION 0x40
#define OP_READ_CAPTURE_STATUS_REG 0x41
#define OP_READ_FIFO_SIZE_LOWER 0x42
#define OP_READ_FIFO_SIZE_MIDDLE 0x43
#define OP_READ_FIFO_SIZE_UPPER 0x44
#define OP_WRITE_TEST_REG (OP_READ_TEST_REG | ARDUCHIP_WRITE_MASK)
#define OP_WRITE_CAPTURE_CONTROL_REG (OP_READ_CAPTURE_CONTROL_REG | ARDUCHIP_WRITE_MASK)
#define OP_WRITE_SENSOR_TIMING_CONTROL_REG (OP_READ_SENSOR_TIMING_CONTROL_REG | ARDUCHIP_WRITE_MASK)
#define OP_WRITE_FIFO_CONTROL_REG (OP_READ_FIFO_CONTROL_REG | ARDUCHIP_WRITE_MASK)
#define OP_WRITE_SENSOR_POWER_CONTROL_REG (OP_READ_SENSOR_POWER_CONTROL_REG | ARDUCHIP_WRITE_MASK)


#define CAMERA_I2C_ADDR 0x3CU
#define CAMERA_GPIO_CHANNEL 1U
#define GPIO_DIRECTION_MASK 0b1111111111U
#define TOGGLE_DELAY 1000000U

// #define PIXEL_MASK 0xFFU
// #define HS_MASK 0x100U
// #define VS_MASK 0x200U

// #define MOSI_MASK 0x02
// #define MISO_MASK 0x01
// #define CS_MASK 0x01
// #define CLK_MASK 0x04

#define DUMMY_BYTE 0xFFU
// Extra byte for command send
#define MAX_BUFF_SIZE_BYTES (6220800 + 1) 
static XIic i2cInst;
static XSpi spiInst;
static u8* ImgBuffer;

void camWriteSensorRegs16_8(const sensor_config_t reglist[], uint16_t reglistLen);

void camConfigureSensor(void);

void initI2C(void){
    // Init i2c
    XIic_Config *ConfigPtr = XIic_LookupConfig(XPAR_AXI_IIC_0_BASEADDR);

    if (ConfigPtr == NULL) {
        return;
    }

	XIic_CfgInitialize(&i2cInst, ConfigPtr,
					    ConfigPtr->BaseAddress);
	
    XIic_SetAddress(&i2cInst, XII_ADDR_TO_SEND_TYPE, CAMERA_I2C_ADDR);
}

void initSpi(void){
    // SPI
    XSpi_Config *SpiConfigPtr = XSpi_LookupConfig(XPAR_AXI_QUAD_SPI_0_BASEADDR);
	XSpi_CfgInitialize(&spiInst, SpiConfigPtr,
				    SpiConfigPtr->BaseAddress);
    
    XSpi_SetOptions(&spiInst, 
         XSP_MASTER_OPTION | XSP_MANUAL_SSELECT_OPTION);

    /*
	 * Start the SPI driver so that the device is enabled.
	 */
	XSpi_Start(&spiInst);
    XSpi_IntrGlobalDisable(&spiInst);

    // Select SPI Device 1
    XSpi_SetSlaveSelect(&spiInst, 0x1);
}

u8 cameraInit(){

    initI2C();
    initSpi();
    u8 cameraID[2];
    // Read ID
    cameraRead(0x300AU, &cameraID[0]);
    cameraRead(0x300BU, &cameraID[1]);
    printf("CameID: %X%X\r\n", cameraID[0], cameraID[1]);

    resetCPLD();

    u8 buf = 0;
    arducamWriteSensorPowerControlReg(SENSOR_POWER_EN_MASK | SENSOR_RESET_MASK);
    arducamReadSensorPowerControlReg(&buf);
    xil_printf("sensor power control set to %X\n\r", buf);
    buf = 0;
    arducamWriteSensorTimingControlReg(VSYNC_ACTIVE_LOW_MASK);
    arducamReadSensorTimingControlReg(&buf);
    xil_printf("sensor timing control set to %X\n\r", buf);

    // while(1){
        // Test Reg operations
        uint8_t byte = 0x55;
        xil_printf("Writing %X to test reg\r\n", byte);
        arducamWriteTestReg(byte);
        byte = 0;
        arducamReadTestReg(&byte);
        xil_printf("Read %X from test reg\r\n", byte);
        
        // arducamReadFWVersion(&byte);
        // xil_printf("FW Version 0x%X\r\n", byte);
    // }
    // delay(100);
    // cameraWrite(0xFF,0x1);
    
    // Make sure sensor vsync timing is set to active low
    arducamReadFWVersion(&byte);
    xil_printf("FW Version 0x%X\r\n", byte);
    //OV5640_init_setting();

    camConfigureSensor();

    // cameraWrite(0x3008, 0x80);
    // camWriteSensorRegs16_8(getCamPreviewConfig(), PREVIEW_CONFIG_LEN);
    // delay(100);
    // camWriteSensorRegs16_8(getCamCaptureConfig(), JPEG_CONFIG_LEN);
    // camWriteSensorRegs16_8(getCamResolutionConfig(), RES_320_240_CONFIG_LEN);
    // delay(100);
    // cameraWrite(0x3818, 0xA8);
    // cameraWrite(0x3621, 0x10);
    // cameraWrite(0x3801, 0xB0);
    // cameraWrite(0x4407, 0x08);
    // cameraWrite(0x5888, 0x00);
    // cameraWrite(0x5000, 0xFF);

    

    // arducamWriteSensorTimingControlReg(VSYNC_ACTIVE_LOW_MASK);
    // camWriteSensorRegs16_8(getCamResolutionConfig(), RES_320_240_CONFIG_LEN);
    // delay(100);
    cameraWrite(0x503D,0x80);
    // arducamWriteFIFOControlReg(FIFO_CLEAR_CAPTURE_DONE_FLAG);
    // arducamWriteCaptureControlReg(0);

    // Malloc buffer
    ImgBuffer = malloc(620000);
    if(ImgBuffer == NULL){
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

void cameraVerify(u16 address, u8 buff){
    u8 buf;
    cameraRead(address,&buf);
    if(buf != buff) {
        xil_printf("cameraVerify failed! address: %X, expected: %X, actual: %X\n\r", address, buff, buf);
        return;
    }
    // xil_printf("cameraVerify success! address: %X, expected: %X, actual: %X", address, buff, buf);
}

void camWriteSensorRegs16_8(const sensor_config_t reglist[], uint16_t reglistLen) {

  for (int i = 0; i < reglistLen; i++) {
    cameraWrite(reglist[i].reg, reglist[i].val);
  }
}

void cameraGroupVerify(const sensor_config_t reglist[], uint16_t reglistLen) {

  for (int i = 0; i < reglistLen; i++) {
    cameraVerify(reglist[i].reg, reglist[i].val);
  }
}

u8 isCaptureDone(void) {
  uint8_t status;
  arducamReadCaptureStatusReg(&status);
//   xil_printf("status %X\r\n", status);
  return status  & STATUS_CAPTURE_DONE_MASK;
}

void camConfigureSensor(void) {
  // Reset camera
  cameraWrite(0x3008, 0x80);
  cameraVerify(0x3008, 0x02);
  // Setup Preview resolution
  camWriteSensorRegs16_8(getCamPreviewConfig(), PREVIEW_CONFIG_LEN);
  cameraGroupVerify(getCamPreviewConfig(), PREVIEW_CONFIG_LEN);
  usleep(2000);
  // Switch to JPEG capture
  camWriteSensorRegs16_8(getCamCaptureConfig(), JPEG_CONFIG_LEN);
  cameraGroupVerify(getCamCaptureConfig(), JPEG_CONFIG_LEN);
  // Switch to lowest JPEG resolution
  camWriteSensorRegs16_8(getCamResolutionConfig(), RES_320_240_CONFIG_LEN);
  cameraGroupVerify(getCamResolutionConfig(), RES_320_240_CONFIG_LEN);

  usleep(1000);
  // Vertical flip
  cameraWrite(0x3818, 0xa8);
  cameraVerify(0x3818, 0xa8);
  // Pixel binning
  cameraWrite(0x3621, 0x10);
  cameraVerify(0x3621, 0x10);
  // Image horizontal control
  cameraWrite(0x3801, 0xb0);
  cameraVerify(0x3801, 0xb0);
  // Image compression
  cameraWrite(0x4407, 0x08);
  cameraVerify(0x4407, 0x08);
  // Lens correction
  cameraWrite(0x5888, 0x00);
  cameraVerify(0x5888, 0x00);
  // Image processor setup
  cameraWrite(0x5000, 0xFF);
  cameraVerify(0x5000, 0xFF);
}

u8 capture(void){
    // Capture
    //OV5640_capture();
    // camConfigureSensor();
    // cameraWrite(0x503D, 0x80);
    arducamWriteFIFOControlReg(FIFO_CLEAR_CAPTURE_DONE_FLAG | FIFO_START_CAPTURE);
    
    while(!isCaptureDone());
    
    u32 byteCount = 0;
    arducamReadFIFOSize(&byteCount);
    xil_printf("Image Size: %d \r\n", byteCount);

    arducamBurstReadFIFO(ImgBuffer, byteCount, MAX_BUFF_SIZE_BYTES);
    
    for (size_t index = 0; index < byteCount; index++) {
      xil_printf("0x%X,", ImgBuffer[index]);
    }
    u8 registerVal;
    arducamReadSensorPowerControlReg(&registerVal);
    // Set standby bit (active high)
    registerVal |= (SENSOR_STANDBY_MASK);
    arducamWriteSensorPowerControlReg(registerVal);

    return XST_SUCCESS;
}

void arducamReadTestReg(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_TEST_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamWriteTestReg(uint8_t value) {
  u8 cmdBuff[2];
  cmdBuff[0] = OP_WRITE_TEST_REG;
  cmdBuff[1] = value;
  XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);
}

void arducamReadCaptureControlReg(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_CAPTURE_CONTROL_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamWriteCaptureControlReg(uint8_t value) {

  if (value > 7) {
    return;
  }

  u8 cmdBuff[2];
  cmdBuff[0] = OP_WRITE_CAPTURE_CONTROL_REG;
  cmdBuff[1] = value;
  XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);
}

void arducamReadSensorTimingControlReg(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_SENSOR_TIMING_CONTROL_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamWriteSensorTimingControlReg(uint8_t value) {
  u8 cmdBuff[2];
  cmdBuff[0] = OP_WRITE_SENSOR_TIMING_CONTROL_REG;
  cmdBuff[1] = value;
  XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);
}

void arducamReadFIFOControlReg(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_FIFO_CONTROL_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamWriteFIFOControlReg(uint8_t value) {
  u8 cmdBuff[2];
  cmdBuff[0] = OP_WRITE_FIFO_CONTROL_REG;
  cmdBuff[1] = value;
  XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);
}

void arducamReadSensorPowerControlReg(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_SENSOR_POWER_CONTROL_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamWriteSensorPowerControlReg(uint8_t value) {
    u8 cmdBuff[2];
    cmdBuff[0] = OP_WRITE_SENSOR_POWER_CONTROL_REG;
    cmdBuff[1] = value;
    XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);
}

void arducamReadFIFO(uint8_t *buffer) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_FIFO_READ;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *buffer = recvBuff[1];
}

void arducamBurstReadFIFO(uint8_t *buffer, size_t readCount, size_t bufferSize) {
  if(readCount>bufferSize){
      xil_printf("readcount > buffer size\r\n");
      return;
  }
  if(readCount < 1){return;}
  buffer[0] = OP_FIFO_BURST_READ;
  XSpi_Transfer(&spiInst, buffer, buffer, readCount);
}

void arducamReadFWVersion(uint8_t *version) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_FW_VERSION;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *version = recvBuff[1];
}

void arducamReadCaptureStatusReg(uint8_t *status) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  cmdBuff[0] = OP_READ_CAPTURE_STATUS_REG;
  cmdBuff[1] = DUMMY_BYTE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  *status = recvBuff[1];
}

void arducamReadFIFOSize(uint32_t *fifoSize) {
  u8 cmdBuff[2];
  u8 recvBuff[2];
  
  cmdBuff[0] = OP_READ_FIFO_SIZE_UPPER;
  cmdBuff[1] = DUMMY_BYTE;
 

  u8 upper = 0;
  u8 middle = 0;
  u8 lower = 0;
  
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  upper = recvBuff[1];

  cmdBuff[0] = OP_READ_FIFO_SIZE_MIDDLE;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  middle = recvBuff[1];

  cmdBuff[0] = OP_READ_FIFO_SIZE_LOWER;
  XSpi_Transfer(&spiInst, cmdBuff, recvBuff, 2);
  lower = recvBuff[1];
  

  *fifoSize = upper;
  *fifoSize = (*fifoSize << 8) | middle;
  *fifoSize = (*fifoSize << 8) | lower;
}

void resetCPLD(void) {
    u8 cmdBuff[2];
    cmdBuff[0] = OP_RESET_CPLD;
    cmdBuff[1] = ARDUCAM_RESET_CPLD_MASK;
    XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);

    // verify
    u8 buf[2];    
    cmdBuff[0] = 0x07;
    cmdBuff[1] = DUMMY_BYTE;
    XSpi_Transfer(&spiInst, cmdBuff, buf, 2);
    xil_printf("CPLD set to %X\n\r", buf[1]);

    usleep(2000);

    cmdBuff[0] = OP_RESET_CPLD; // need to reset
    cmdBuff[1] = ARDUCAM_RESET_CPLD_MASK & (~ARDUCAM_RESET_CPLD_MASK);
    XSpi_Transfer(&spiInst, cmdBuff, NULL, 2);

    // verify
    buf[1] = 0x00;
    cmdBuff[0] = 0x07;
    cmdBuff[1] = DUMMY_BYTE;
    XSpi_Transfer(&spiInst, cmdBuff, buf, 2);
    xil_printf("CPLD set to %X\n\r", buf[1]);
}


