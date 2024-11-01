#ifndef CAPTURE_H
#define CAPTURE_H

#include "camera.h"
#include "xil_types.h"
#include <stddef.h>

int m_iCombo_NightMode = 0;
int XVCLK = 2400; // real clock/10000
int preview_sysclk, preview_HTS, preview_VTS;
int AE_Target = 52;
int AE_high, AE_low;

void delay(u8 durationMs){
    size_t cycleCount = durationMs * 667000;
    for(volatile size_t i=0; i < cycleCount; i++){};
}

int OV5640_init_setting()
{
    // initialize OV5640
    int regInit[] =
        {
            //
            // OV5640 setting Version History
            // dated 04/08/2010 A02
            //--Based on v08 release
            //
            // dated 04/20/2010 A03
            //--Based on V10 release
            //
            // dated 04/22/2010 A04
            //--Based on V10 release
            //--updated ccr & awb setting
            //
            // dated 04/22/2010 A06
            //--Based on A05 release
            //--Add pg setting
            //
            // dated 05/19/2011 A09
            //--changed pchg 3708 setting
            0x3008, 0x42, // software power down
            0x3103, 0x03, // sysclk from pll
            0x3017, 0xef, // Frex, Vsync, Href, PCLK, D[9:6] output
            0x3018, 0xff, // D[5:0], GPIO[1:0] output
            0x3034, 0x1a, // PLL, MIPI 10-bit
            0x3037, 0x13, // PLL
            0x3108, 0x01, // clock divider
            0x3630, 0x36,
            0x3631, 0x0e,
            0x3632, 0xe2,
            0x3633, 0x12,
            0x3621, 0xe0,
            0x3704, 0xa0,
            0x3703, 0x5a,
            0x3715, 0x78,
            0x3717, 0x01,
            0x370b, 0x60,
            0x3705, 0x1a,
            0x3905, 0x02,
            0x3906, 0x10,
            0x3901, 0x0a,
            0x3731, 0x12,
            0x3600, 0x08, // VCM debug
            0x3601, 0x33, // VCM debug
            0x302d, 0x60, // system control
            0x3620, 0x52,
            0x371b, 0x20,
            0x471c, 0x50,

            0x3a13, 0x43, // pre-gain = 1.05x
            0x3a18, 0x00, // AEC gain ceiling = 7.75x
            0x3a19, 0x7c, // AEC gain ceiling
            0x3635, 0x13,
            0x3636, 0x03,
            0x3634, 0x40,
            0x3622, 0x01,
            // 50/60Hz detection
            0x3c01, 0x34, // sum auto, band counter enable, threshold = 4
            0x3c04, 0x28, // threshold low sum
            0x3c05, 0x98, // threshold high sum
            0x3c06, 0x00, // light meter 1 threshold H
            0x3c07, 0x07, // light meter 1 threshold L
            0x3c08, 0x00, // light meter 2 threshold H
            0x3c09, 0x1c, // light meter 2 threshold L
            0x3c0a, 0x9c, // sample number H
            0x3c0b, 0x40, // sample number L
            0x3810, 0x00, // X offset
            0x3811, 0x10, // X offset
            0x3812, 0x00, // Y offset
            0x3708, 0x64,
            0x4001, 0x02, // BLC start line
            0x4005, 0x1a, // BLC always update
            0x3000, 0x00, // enable MCU, OTP
            0x3004, 0xff, // enable BIST, MCU memory, MCU, OTP, STROBE, D5060, timing, array clock
            0x300e, 0x58, // MIPI 2 lane? power down PHY HS TX, PHY LP RX, DVP enable
            0x302e, 0x00,
            0x4300, 0x30, // YUV 422, YUYV
            0x501f, 0x00, // ISP YUV 422
            0x440e, 0x00,
            0x5000, 0xa7, // LENC on, raw gamma on, BPC on, WPC on, CIP on
            // AEC target
            0x3a0f, 0x30, // stable in high
            0x3a10, 0x28, // stable in low
            0x3a1b, 0x30, // stable out high
            0x3a1e, 0x26, // stable out low
            0x3a11, 0x60, // fast zone high
            0x3a1f, 0x14, // fast zone low
            // LENC
            0x5800, 0x23,
            0x5801, 0x14,
            0x5802, 0x0f,
            0x5803, 0x0f,
            0x5804, 0x12,
            0x5805, 0x26,
            0x5806, 0x0c,
            0x5807, 0x08,
            0x5808, 0x05,
            0x5809, 0x05,
            0x580a, 0x08,
            0x580b, 0x0d,
            0x580c, 0x08,
            0x580d, 0x03,
            0x580e, 0x00,
            0x580f, 0x00,
            0x5810, 0x03,
            0x5811, 0x09,
            0x5812, 0x07,
            0x5813, 0x03,
            0x5814, 0x00,
            0x5815, 0x01,

            0x5816, 0x03,
            0x5817, 0x08,
            0x5818, 0x0d,
            0x5819, 0x08,
            0x581a, 0x05,
            0x581b, 0x06,
            0x581c, 0x08,
            0x581d, 0x0e,
            0x581e, 0x29,
            0x581f, 0x17,
            0x5820, 0x11,
            0x5821, 0x11,
            0x5822, 0x15,
            0x5823, 0x28,
            0x5824, 0x46,
            0x5825, 0x26,
            0x5826, 0x08,
            0x5827, 0x26,
            0x5828, 0x64,
            0x5829, 0x26,
            0x582a, 0x24,
            0x582b, 0x22,
            0x582c, 0x24,
            0x582d, 0x24,
            0x582e, 0x06,
            0x582f, 0x22,
            0x5830, 0x40,
            0x5831, 0x42,
            0x5832, 0x24,
            0x5833, 0x26,
            0x5834, 0x24,
            0x5835, 0x22,
            0x5836, 0x22,
            0x5837, 0x26,
            0x5838, 0x44,
            0x5839, 0x24,
            0x583a, 0x26,
            0x583b, 0x28,
            0x583c, 0x42,
            0x583d, 0xce, // LENC BR offset
            // AWB
            0x5180, 0xff, // AWB B block
            0x5181, 0xf2, // AWB control
            0x5182, 0x00, // [7:4] max local counter, [3:0] max fast counter
            0x5183, 0x14, // AWB advance
            0x5184, 0x25,
            0x5185, 0x24,
            0x5186, 0x09,
            0x5187, 0x09,
            0x5188, 0x09,
            0x5189, 0x75,
            0x518a, 0x54,
            0x518b, 0xe0,
            0x518c, 0xb2,
            0x518d, 0x42,
            0x518e, 0x3d,
            0x518f, 0x56,
            0x5190, 0x46,
            0x5191, 0xf8, // AWB top limit
            0x5192, 0x04, // AWB botton limit
            0x5193, 0x70, // Red limit
            0x5194, 0xf0, // Green Limit
            0x5195, 0xf0, // Blue limit

            0x5196, 0x03, // AWB control
            0x5197, 0x01, // local limit
            0x5198, 0x04,
            0x5199, 0x12,
            0x519a, 0x04,
            0x519b, 0x00,
            0x519c, 0x06,
            0x519d, 0x82,
            0x519e, 0x38, // AWB control
            // Gamma
            0x5480, 0x01, // BIAS plus on
            0x5481, 0x08,
            0x5482, 0x14,
            0x5483, 0x28,
            0x5484, 0x51,
            0x5485, 0x65,
            0x5486, 0x71,
            0x5487, 0x7d,
            0x5488, 0x87,
            0x5489, 0x91,
            0x548a, 0x9a,
            0x548b, 0xaa,
            0x548c, 0xb8,
            0x548d, 0xcd,
            0x548e, 0xdd,
            0x548f, 0xea,
            0x5490, 0x1d,
            // color matrix
            0x5381, 0x1e, // CMX1 for Y
            0x5382, 0x5b, // CMX2 for Y
            0x5383, 0x08, // CMX3 for Y
            0x5384, 0x0a, // CMX4 for U
            0x5385, 0x7e, // CMX5 for U
            0x5386, 0x88, // CMX6 for U
            0x5387, 0x7c, // CMX7 for V
            0x5388, 0x6c, // CMX8 for V
            0x5389, 0x10, // CMX9 for V
            0x538a, 0x01, // sign[9]
            0x538b, 0x98, // sign[8:1]
            // UV adjust
            0x5580, 0x06, // brightness on, saturation on
            0x5583, 0x40, // Sat U
            0x5584, 0x10, // Sat V
            0x5589, 0x10, // UV adjust th1
            0x558a, 0x00, // UV adjust th2[8]
            0x558b, 0xf8, // UV adjust th2[7:0]
            0x501d, 0x40, // enable manual offset in contrast
            // CIP
            0x5300, 0x08, // sharpen-MT th1
            0x5301, 0x30, // sharpen-MT th2
            0x5302, 0x10, // sharpen-MT off1
            0x5303, 0x00, // sharpen-MT off2
            0x5304, 0x08, // De-noise th1
            0x5305, 0x30, // De-noise th2
            0x5306, 0x08, // De-noise off1
            0x5307, 0x16, // De-noise off2
            0x5309, 0x08, // sharpen-TH th1
            0x530a, 0x30, // sharpen-TH th2
            0x530b, 0x04, // sharpen-TH off1
            0x530c, 0x06, // sharpen-TH off2

            0x5025, 0x00,
            0x3008, 0x02, // wake up from software power down
        };
    cameraWrite(0x3103, 0x11); // sysclk from pad
    cameraWrite(0x3008, 0x82); // software reset
                                    // delay 5ms
    delay(5);
    // Write initialization table
    for (size_t i = 0; i < sizeof(regInit) / sizeof(int); i += 2)
    {
        cameraWrite(regInit[i], regInit[i + 1]);
    }
    return 0;
}
int OV5640_preview_setting()
{
    // set OV5640 to preview mode
    int regPreview[] =
        {
            // 640x480 15fps, night mode 5fps
            // Input CLock = 24Mhz
            // PCLK = 17Mhz
            0x3035, 0x21, // PLL
            0x3036, 0x46, // PLL
            0x3c07, 0x08, // lightmeter 1 threshold[7:0]
            0x3820, 0x41, // flip
            0x3821, 0x07, // mirror
            0x3814, 0x31, // timing X inc
            0x3815, 0x31, // timing Y inc
            0x3800, 0x00, // HS
            0x3801, 0x00, // HS
            0x3802, 0x00, // VS
            0x3803, 0x04, // VS
            0x3804, 0x0a, // HW (HE)
            0x3805, 0x3f, // HW (HE)
            0x3806, 0x07, // VH (VE)
            0x3807, 0x9b, // VH (VE)
            0x3808, 0x02, // DVPHO
            0x3809, 0x80, // DVPHO
            0x380a, 0x01, // DVPVO
            0x380b, 0xe0, // DVPVO
            0x380c, 0x07, // HTS
            0x380d, 0x68, // HTS
            0x380e, 0x03, // VTS
            0x380f, 0xd8, // VTS
            0x3813, 0x06, // timing V offset
            0x3618, 0x00,
            0x3612, 0x29,
            0x3709, 0x52,
            0x370c, 0x03,
            0x3a02, 0x0b, // 60Hz max exposure, night mode 5fps
            0x3a03, 0x88, // 60Hz max exposure
            0x3a14, 0x0b, // 50Hz max exposure, night mode 5fps
            0x3a15, 0x88, // 50Hz max exposure
            0x4004, 0x02, // BLC line number
            0x3002, 0x1c, // reset JFIFO, SFIFO, JPG
            0x3006, 0xc3, // disable clock of JPEG2x, JPEG
            0x4713, 0x03, // JPEG mode 3

            0x4407, 0x04, // Quantization sacle
            0x460b, 0x35,
            0x460c, 0x22,
            0x4837, 0x22, // MIPI global timing
            0x3824, 0x02, // PCLK manual divider
            0x5001, 0xa3, // SDE on, CMX on, AWB on
            0x3503, 0x00, // AEC/AGC on
        };
    // Write preview table
    for (size_t i = 0; i < sizeof(regPreview) / sizeof(int); i += 2)
    {
        cameraWrite(regPreview[i], regPreview[i + 1]);
    }
    return 0;
}
int OV5640_video_setting()
{
    // set OV5640 to video mode
    int regVideo[] =
        {
            // input clock 24Mhz
            // PCLK 42Mhz
            0x3035, 0x41, // PLL
            0x3036, 0x69, // PLL
            0x3c07, 0x07, // lightmeter 1 threshold[7:0]
            0x3820, 0x41, // flip
            0x3821, 0x07, // mirror
            0x3814, 0x31, // timing X inc
            0x3815, 0x31, // timing Y inc
            0x3800, 0x00, // HS
            0x3801, 0x00, // HS
            0x3802, 0x00, // VS
            0x3803, 0xfa, // VS
            0x3804, 0x0a, // HW (HE)
            0x3805, 0x3f, // HW (HE)
            0x3806, 0x06, // VH (VE)
            0x3807, 0xa9, // VH (VE)
            0x3808, 0x05, // DVPHO
            0x3809, 0x00, // DVPHO
            0x380a, 0x02, // DVPVO
            0x380b, 0xd0, // DVPVO
            0x380c, 0x07, // HTS
            0x380d, 0x64, // HTS
            0x380e, 0x02, // VTS
            0x380f, 0xe4, // VTS
            0x3813, 0x04, // timing V offset
            0x3618, 0x00,
            0x3612, 0x29,
            0x3709, 0x52,
            0x370c, 0x03,
            0x3a02, 0x02, // 60Hz max exposure
            0x3a03, 0xe0, // 60Hz max exposure
            0x3a08, 0x00, // B50 step
            0x3a09, 0x6f, // B50 step
            0x3a0a, 0x00, // B60 step
            0x3a0b, 0x5c, // B60 step
            0x3a0e, 0x06, // 50Hz max band
            0x3a0d, 0x08, // 60Hz max band
            0x3a14, 0x02, // 50Hz max exposure
            0x3a15, 0xe0, // 50Hz max exposure
            0x4004, 0x02, // BLC line number

            0x3002, 0x1c, // reset JFIFO, SFIFO, JPG
            0x3006, 0xc3, // disable clock of JPEG2x, JPEG
            0x4713, 0x03, // JPEG mode 3
            0x4407, 0x04, // Quantization sacle
            0x460b, 0x37,
            0x460c, 0x20,
            0x4837, 0x16, // MIPI global timing
            0x3824, 0x04, // PCLK manual divider
            0x5001, 0x83, // SDE on, CMX on, AWB on
            0x3503, 0x00, // AEC/AGC on
        };
    // Write preview table
    for (size_t i = 0; i < sizeof(regVideo) / sizeof(int); i += 2)
    {
        cameraWrite(regVideo[i], regVideo[i + 1]);
    }
    return 0;
}
int OV5640_capture_setting()
{
    // set OV5640 to capture mode
    int regCapture[] =
        {
            // YUV Capture
            // 2592 x 1944 3.75fps
            // 24 MHz input clock, 42Mhz PCLK
            0x3035, 0x71, // PLL
            0x3036, 0x69, // PLL
            0x3c07, 0x07, // lightmeter 1 threshold[7:0]
            0x3820, 0x40, // flip
            0x3821, 0x06, // mirror
            0x3814, 0x11, // timing X inc
            0x3815, 0x11, // timing Y inc
            0x3800, 0x00, // HS
            0x3801, 0x00, // HS
            0x3802, 0x00, // VS
            0x3803, 0x00, // VS
            0x3804, 0x0a, // HW (HE)
            0x3805, 0x3f, // HW (HE)
            0x3806, 0x07, // VH (VE)
            0x3807, 0x9f, // VH (VE)
            0x3808, 0x0a, // DVPHO
            0x3809, 0x20, // DVPHO
            0x380a, 0x07, // DVPVO
            0x380b, 0x98, // DVPVO
            0x380c, 0x0b, // HTS
            0x380d, 0x1c, // HTS
            0x380e, 0x07, // VTS
            0x380f, 0xb0, // VTS
            0x3813, 0x04, // timing V offset
            0x3618, 0x04,
            0x3612, 0x2b,
            0x3709, 0x12,
            0x370c, 0x00,
            0x4004, 0x06, // BLC line number
            0x3002, 0x1c, // reset JFIFO, SFIFO, JPG
            0x3006, 0xc3, // disable clock of JPEG2x, JPEG
            0x4713, 0x02, // JPEG mode 2
            0x4407, 0x0c, // Quantization sacle
            0x460b, 0x37,
            0x460c, 0x20,

            0x4837, 0x2c, // MIPI global timing
            0x3824, 0x01, // PCLK manual divider
            0x5001, 0x83, // SDE on, CMX on, AWB on, scale off
            0x3503, 0x03, // AEC/AGC off
        };
    // Write capture table
    for (size_t i = 0; i < sizeof(regCapture) / sizeof(int); i += 2)
    {
        cameraWrite(regCapture[i], regCapture[i + 1]);
    }
    return 0;
}

int OV5640_get_sysclk()
{
    // calculate sysclk
    u8 byte;
    int temp2;
    int Multiplier, PreDiv, VCO, SysDiv, Pll_rdiv, Bit_div2x, sclk_rdiv, sysclk;
    int sclk_rdiv_map[] = {
        1, 2, 4, 8};
    cameraRead(0x3034, &byte);
    temp2 = byte & 0x0f;
    if (temp2 == 8 || temp2 == 10)
    {
        Bit_div2x = temp2 / 2;
    } else {
        Bit_div2x = 1;
    }
    cameraRead(0x3035, &byte);
    SysDiv = byte >> 4;
    if (SysDiv == 0)
    {
        SysDiv = 16;
    }
    cameraRead(0x3036, &byte);
    Multiplier = byte;
    cameraRead(0x3037,&byte);
    PreDiv = byte & 0x0f;
    Pll_rdiv = ((byte >> 4) & 0x01) + 1;
    cameraRead(0x3108,&byte);
    temp2 = byte & 0x03;
    sclk_rdiv = sclk_rdiv_map[temp2];
    VCO = XVCLK * Multiplier / PreDiv;
    sysclk = VCO / SysDiv / Pll_rdiv * 2 / Bit_div2x / sclk_rdiv;
    return sysclk;
}
int OV5640_get_HTS()
{
    // read HTS from register settings
    int HTS;
    u8 byte;
    cameraRead(0x380c, &byte);
    HTS = byte;
    cameraRead(0x380d, &byte);
    HTS = (HTS << 8) + byte;
    return HTS;
}
int OV5640_get_VTS()
{
    // read VTS from register settings
    int VTS;
    u8 byte;
    cameraRead(0x380e, &byte);
    VTS = byte;
    cameraRead(0x380f, &byte);
    VTS = (VTS << 8) + byte;
    return VTS;
}
int OV5640_set_VTS(int VTS)
{
    // write VTS to registers
    int temp;
    temp = VTS & 0xff;
    cameraWrite(0x380f, temp);
    temp = VTS >> 8;
    cameraWrite(0x380e, temp);
    return 0;
}
int OV5640_get_shutter()
{
    // read shutter, in number of line period
    int shutter;
    u8 byte;    
    cameraRead(0x03500, &byte);
    shutter = (byte & 0x0f);
    cameraRead(0x3501, &byte);
    shutter = (shutter << 8) + byte;
    cameraRead(0x3502, &byte);
    shutter = (shutter << 4) + (byte >> 4);

    return shutter;
}
int OV5640_set_shutter(int shutter)
{
    // write shutter, in number of line period
    int temp;
    shutter = shutter & 0xffff;
    temp = shutter & 0x0f;
    temp = temp << 4;
    cameraWrite(0x3502, temp);
    temp = shutter & 0xfff;
    temp = temp >> 4;
    cameraWrite(0x3501, temp);
    temp = shutter >> 12;
    cameraWrite(0x3500, temp);
    return 0;
}
int OV5640_get_gain16()
{
    // read gain, 16 = 1x
    int gain16;
    u8 byte;
    cameraRead(0x350a, &byte);
    gain16 =  byte & 0x03;
    cameraRead(0x350b, &byte);
    gain16 = (gain16 << 8) + byte;
    return gain16;
}
int OV5640_set_gain16(int gain16)
{
    // write gain, 16 = 1x
    int temp;
    gain16 = gain16 & 0x3ff;
    temp = gain16 & 0xff;
    cameraWrite(0x350b, temp);
    temp = gain16 >> 8;
    cameraWrite(0x350a, temp);
    return 0;
}
int OV5640_get_light_frequency()
{
    // get banding filter value
    int light_frequency;
    u8 byte;
    cameraRead(0x3c01, &byte);
    if (byte & 0x80)
    {
        // manual
        cameraRead(0x3c00, &byte);
        if (byte & 0x04)
        {
            // 50Hz
            light_frequency = 50;
        }
        else
        {
            // 60Hz
            light_frequency = 60;
        }
    }
    else
    {
        // auto
        cameraRead(0x3c0c, &byte);
        if (byte & 0x01)
        {
            // 50Hz
            light_frequency = 50;
        }
        else
        {
            // 60Hz
            light_frequency = 60;
        }
    }
    return light_frequency;
}
void OV5640_set_bandingfilter()
{
    int preview_VTS;
    int band_step60, max_band60, band_step50, max_band50;
    // read preview PCLK
    preview_sysclk = OV5640_get_sysclk();
    // read preview HTS
    preview_HTS = OV5640_get_HTS();
    // read preview VTS
    preview_VTS = OV5640_get_VTS();
    // calculate banding filter
    // 60Hz
    band_step60 = preview_sysclk * 100 / preview_HTS * 100 / 120;
    cameraWrite(0x3a0a, (band_step60 >> 8));
    cameraWrite(0x3a0b, (band_step60 & 0xff));
    max_band60 = (int)((preview_VTS - 4) / band_step60);
    cameraWrite(0x3a0d, max_band60);
    // 50Hz
    band_step50 = preview_sysclk * 100 / preview_HTS;
    cameraWrite(0x3a08, (band_step50 >> 8));
    cameraWrite(0x3a09, (band_step50 & 0xff));
    max_band50 = (int)((preview_VTS - 4) / band_step50);
    cameraWrite(0x3a0e, max_band50);
}
int OV5640_set_AE_target(int target)
{
    // stable in high
    int fast_high, fast_low;
    AE_low = target * 23 / 25;  // 0.92
    AE_high = target * 27 / 25; // 1.08
    fast_high = AE_high << 1;
    if (fast_high > 255)
        fast_high = 255;
    fast_low = AE_low >> 1;

    cameraWrite(0x3a0f, AE_high);
    cameraWrite(0x3a10, AE_low);
    cameraWrite(0x3a1b, AE_high);
    cameraWrite(0x3a1e, AE_low);
    cameraWrite(0x3a11, fast_high);
    cameraWrite(0x3a1f, fast_low);
    return 0;
}
int OV5640_init()
{
    // initialize OV5640
    OV5640_init_setting();
    return 0;
}
int OV5640_preview()
{
    // set OV5640 to preview mode
    OV5640_preview_setting();
    // calculate banding filter
    OV5640_set_bandingfilter();
    // set ae_target
    OV5640_set_AE_target(AE_Target);
    // update night mode setting
    //OV5640_set_night_mode(m_iCombo_NightMode);
    
    return 0;
}
int OV5640_return_to_preview()
{
    // release focus
    cameraWrite(0x3022, 0x08);
    // set OV5640 to preview mode
    OV5640_preview_setting();
    // calculate banding filter
    OV5640_set_bandingfilter();
    // set ae_target
    OV5640_set_AE_target(AE_Target);
    // update night mode setting
    // OV5640_set_night_mode(m_iCombo_NightMode);
    // re-launch auto focus zones
    cameraWrite(0x3022, 0x12);
    return 0;
}
int OV5640_video()
{

    // set OV5640 to video mode
    OV5640_video_setting();
    // calculate banding filter
    OV5640_set_bandingfilter();
    // set ae_target
    OV5640_set_AE_target(AE_Target);
    // turn off night mmode
    // OV5640_set_night_mode(0);
    return 0;
}
int OV5640_capture()
{
    // set OV5640 to capture mode
    int preview_shutter, preview_gain16, average;
    int capture_shutter, capture_gain16;
    int capture_sysclk, capture_HTS, capture_VTS;
    int light_frequency, capture_bandingfilter, capture_max_band;
    long capture_gain16_shutter;
    u8 byte;
    // read preview shutter
    preview_shutter = OV5640_get_shutter();
    // read preview gain
    preview_gain16 = OV5640_get_gain16();
    // get average
    cameraRead(0x56a1, &byte);
    average = byte;
    // turn off night mode for capture
    // OV5640_set_night_mode(0);
    // turn off overlay
    cameraWrite(0x3022, 0x06);
    // Write capture setting
    OV5640_capture_setting();
    // read capture VTS
    capture_VTS = OV5640_get_VTS();
    capture_HTS = OV5640_get_HTS();
    capture_sysclk = OV5640_get_sysclk();
    // calculate capture banding filter
    light_frequency = OV5640_get_light_frequency();
    if (light_frequency == 60)
    {
        // 60Hz
        capture_bandingfilter = capture_sysclk * 100 / capture_HTS * 100 / 120;
    }
    else
    {
        // 50Hz
        capture_bandingfilter = capture_sysclk * 100 / capture_HTS;
    }
    capture_max_band = (int)((capture_VTS - 4) / capture_bandingfilter);
    // calculate capture shutter/gain16

    if (average > AE_low && average < AE_high)
    {
        // in stable range
        capture_gain16_shutter = preview_gain16 * preview_shutter * capture_sysclk / preview_sysclk *
                                 preview_HTS / capture_HTS * AE_Target / average;
    }
    else
    {
        capture_gain16_shutter = preview_gain16 * preview_shutter * capture_sysclk / preview_sysclk *
                                 preview_HTS / capture_HTS;
    }
    // gain to shutter
    if (capture_gain16_shutter < (capture_bandingfilter * 16))
    {
        // shutter < 1/100
        capture_shutter = capture_gain16_shutter / 16;
        if (capture_shutter < 1)
            capture_shutter = 1;
        capture_gain16 = capture_gain16_shutter / capture_shutter;
        if (capture_gain16 < 16)
            capture_gain16 = 16;
    }
    else
    {
        if (capture_gain16_shutter > (capture_bandingfilter * capture_max_band * 16))
        {
            // exposure reach max
            capture_shutter = capture_bandingfilter * capture_max_band;
            capture_gain16 = capture_gain16_shutter / capture_shutter;
        }
        else
        {
            // 1/100 < capture_shutter =< max, capture_shutter = n/100
            capture_shutter = ((int)(capture_gain16_shutter / 16 / capture_bandingfilter)) * capture_bandingfilter;
            capture_gain16 = capture_gain16_shutter / capture_shutter;
        }
    }
    // write capture gain
    OV5640_set_gain16(capture_gain16);
    // write capture shutter
    if (capture_shutter > (capture_VTS - 4))
    {
        capture_VTS = capture_shutter + 4;
        OV5640_set_VTS(capture_VTS);
    }
    OV5640_set_shutter(capture_shutter);


    // skip 2 vysnc
    // start capture at 3rd vsync
    return 0;
}

#endif
