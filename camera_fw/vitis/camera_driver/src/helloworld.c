#include "camera_driver/camera.h"
#include "platform.h"
#include "xparameters.h"
#include "xil_printf.h"


int main(void)
{
	cameraInit();
    capture();
}
