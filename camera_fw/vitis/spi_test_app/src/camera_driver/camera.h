#ifndef CAMERA_H
#define CAMERA_H

#include "xparameters.h"
#include "xil_types.h"

#include <stdio.h>

u8 cameraInit(void);

u8 cameraWrite(u16 address, u8 value);
u8 cameraRead(u16 address, u8* buff);

u8 cameraReadPixel(void);
u8 capture(void);

void arducamReadTestReg(uint8_t *buffer);

void arducamWriteTestReg(uint8_t value);

void arducamReadCaptureControlReg(uint8_t *buffer);

void arducamWriteCaptureControlReg(uint8_t value);

void arducamReadSensorTimingControlReg(uint8_t *buffer);

void arducamWriteSensorTimingControlReg(uint8_t value);

void arducamReadFIFOControlReg(uint8_t *buffer);

void arducamWriteFIFOControlReg(uint8_t value);

void arducamReadSensorPowerControlReg(uint8_t *buffer);
void arducamWriteSensorPowerControlReg(uint8_t value);
void arducamReadFIFO(uint8_t *buffer);
void arducamBurstReadFIFO(uint8_t *buffer, size_t readize, size_t bufferSize);
void arducamReadFWVersion(uint8_t *version);
void arducamReadCaptureStatusReg(uint8_t *status);
void arducamReadFIFOSize(uint32_t *fifoSize);
void resetCPLD(void);

#endif