#ifndef CAMERA_H
#include "xparameters.h"
#include "xil_types.h"

#include <stdio.h>

u8 cameraInit(void);

u8 cameraWrite(u16 address, u8 value);
u8 cameraRead(u16 address, u8* buff);

u8 cameraReadPixel(void);
u8 capture(void);
#endif