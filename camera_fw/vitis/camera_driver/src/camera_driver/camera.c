#include "camera.h"
#include "capture.h"
#include "xiic.h"
#include "xiic_l.h"
#include "xgpio.h"
#include "xstatus.h"
#include "xparameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
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

#define PIXEL_MASK 0xFFU
#define HS_MASK 0x100U
#define VS_MASK 0x200U

static XIic i2cInst;
static XGpio gpioInstInput;
static XGpio gpioInstOutput;
static u8* ImgBuffer;

static u8 dataMask = 1;

void csAssert(){
    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0);
    dataMask &= ~(0x01);
}

void csDeassert(){
    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 1);
    dataMask |= 0x1;
}

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

    XGpio_SetDataDirection(&gpioInstInput,CAMERA_GPIO_CHANNEL, 1);
    XGpio_SetDataDirection(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0);
    while(1){
        int temp = XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL);
        printf("%d\r\n", temp);
        XGpio_DiscreteSet(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0xFF);
        XGpio_DiscreteClear(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0xFF);
    }
    csDeassert();
    // Malloc buffer

    ImgBuffer = malloc(6220800);
    if(ImgBuffer == NULL){
        printf("malloc failed\r\n");
    }
    
    u8 cameraID[2];
    // Read ID
    cameraRead(0x300AU, &cameraID[0]);
    cameraRead(0x300BU, &cameraID[1]);
    printf("CameID: %X%X\r\n", cameraID[0], cameraID[1]);
    
    
    // Test Reg operations
    uint8_t byte = 0x55;
    xil_printf("Writing %d to test reg\r\n", byte);
    arducamWriteTestReg(byte);
    byte = 0;
    arducamReadTestReg(&byte);
    xil_printf("Read %d from test reg\r\n", byte);
    resetCPLD();
    arducamWriteSensorPowerControlReg(SENSOR_POWER_EN_MASK | SENSOR_RESET_MASK);
    // Make sure sensor vsync timing is set to active low
    arducamWriteSensorTimingControlReg(VSYNC_ACTIVE_LOW_MASK);

    OV5640_init_setting();
    
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
    return (XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & HS_MASK)?1:0;
}

u8 readVS(void){
    return (XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & VS_MASK)? 1:0;
}

u8 cameraReadPixel(void){
    return XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL) & PIXEL_MASK;
}

u8 togglePS(void){
    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 1);

    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, 0);
    return XST_SUCCESS;
}

u8 isCaptureDone(void) {
  uint8_t status;
  arducamReadCaptureStatusReg(&status);
  return status  & STATUS_CAPTURE_DONE_MASK;
}

u8 capture(void){
    // Capture
    OV5640_capture();
    cameraWrite(0x503D, 0x80);
    arducamWriteFIFOControlReg(FIFO_CLEAR_CAPTURE_DONE_FLAG | FIFO_START_CAPTURE);
    
    while(!isCaptureDone());
    
    u32 byteCount = 0;
    arducamReadFIFOSize(&byteCount);
    arducamBurstReadFIFO(ImgBuffer, byteCount);

    for (size_t index = 0; index < byteCount; index++) {
      xil_printf("0x%X,", ImgBuffer[index]);
    }
    u8 registerVal;
    arducamReadSensorPowerControlReg(&registerVal);
    // Set standby bit (active high)
    registerVal |= (SENSOR_STANDBY_MASK);
    arducamWriteSensorPowerControlReg(registerVal);
}


void clockHigh(){
    dataMask |= 0x8;
    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, dataMask);

}

void clockLow(){
    dataMask &= ~(0x8);
    XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, dataMask);
}

void spiWrite(u8 data){
    for(int i=0x80; i>0;i>>=1){
        u8 BitOut = data & i;
        dataMask = (BitOut)? (dataMask | 0x2) : (dataMask & ~(0x2));
        XGpio_DiscreteWrite(&gpioInstOutput, CAMERA_GPIO_CHANNEL, dataMask);
        clockHigh();
        clockLow();
    }
}

void spiRead(u8* data){
    *data = 0;
    for(int i=0; i<8;i++){
        clockHigh();
        *data <<= 1;
        *data |= (XGpio_DiscreteRead(&gpioInstInput, CAMERA_GPIO_CHANNEL)&0x1);
        clockLow();
    }
}

void arducamReadTestReg(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_READ_TEST_REG);
  spiRead(buffer);
  csDeassert();
}

void arducamWriteTestReg(uint8_t value) {
  csAssert();
  spiWrite(OP_WRITE_TEST_REG);
  spiWrite(value);
  csDeassert();
}

void arducamReadCaptureControlReg(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_READ_CAPTURE_CONTROL_REG);
  spiRead(buffer);
  csDeassert();
}

void arducamWriteCaptureControlReg(uint8_t value) {

  if (value > 7) {
    return;
  }

  csAssert();
  spiWrite(OP_WRITE_CAPTURE_CONTROL_REG);
  spiWrite(value);
  csDeassert();
}

void arducamReadSensorTimingControlReg(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_READ_SENSOR_TIMING_CONTROL_REG);
  spiRead(buffer);
  csDeassert();
}

void arducamWriteSensorTimingControlReg(uint8_t value) {
  csAssert();
  spiWrite(OP_WRITE_SENSOR_TIMING_CONTROL_REG);
  spiWrite(value);
  csDeassert();
}

void arducamReadFIFOControlReg(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_READ_FIFO_CONTROL_REG);
  spiRead(buffer);
  csDeassert();
}

void arducamWriteFIFOControlReg(uint8_t value) {
  csAssert();
  spiWrite(OP_WRITE_FIFO_CONTROL_REG);
  spiWrite(value);
  csDeassert();
}

void arducamReadSensorPowerControlReg(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_READ_SENSOR_POWER_CONTROL_REG);
  spiRead(buffer);
  csDeassert();
}

void arducamWriteSensorPowerControlReg(uint8_t value) {
  csAssert();
  spiWrite(OP_WRITE_SENSOR_POWER_CONTROL_REG);
  spiWrite(value);
  csDeassert();
}

void arducamReadFIFO(uint8_t *buffer) {
  csAssert();
  spiWrite(OP_FIFO_READ);
  spiRead(buffer);
  csDeassert();
}

void arducamBurstReadFIFO(uint8_t *buffer, size_t bufferSize) {
  csAssert();
  spiWrite(OP_FIFO_BURST_READ);
  for (size_t index = 0; (index < bufferSize); index++) {
    spiRead(buffer);
    buffer++;
  }
  csDeassert();
  
}

void arducamReadFWVersion(uint8_t *version) {
  csAssert();
  spiWrite(OP_READ_FW_VERSION);
  spiRead(version);
  csDeassert();
}

void arducamReadCaptureStatusReg(uint8_t *status) {
  csAssert();
  spiWrite(OP_READ_CAPTURE_STATUS_REG);
  spiRead(status);
  csDeassert();
}

void arducamReadFIFOSize(uint32_t *fifoSize) {
  u8 upper = 0;
  u8 middle = 0;
  u8 lower = 0;

  csAssert();
  spiWrite(OP_READ_FIFO_SIZE_UPPER);
  spiRead(&upper);
  csDeassert();


  csAssert();
  spiWrite(OP_READ_FIFO_SIZE_MIDDLE);
  spiRead(&middle);
  csDeassert();

  csAssert();
  spiWrite(OP_READ_FIFO_SIZE_LOWER);
  spiRead(&lower);
  csDeassert();
  

  *fifoSize = upper;
  *fifoSize = (*fifoSize << 8) | middle;
  *fifoSize = (*fifoSize << 8) | lower;
}

void resetCPLD(void) {
  csAssert();
  spiWrite(OP_RESET_CPLD);
  spiWrite(ARDUCAM_RESET_CPLD_MASK);
  csDeassert();
  delay(2);

  csAssert();
  spiWrite(OP_RESET_CPLD);
  spiWrite(ARDUCAM_RESET_CPLD_MASK & (~ARDUCAM_RESET_CPLD_MASK));
  csDeassert();
}


