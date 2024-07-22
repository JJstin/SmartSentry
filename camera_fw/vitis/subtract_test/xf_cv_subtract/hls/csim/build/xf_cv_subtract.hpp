#include "core/xf_arithm.hpp"

#define STR(x)   #x
#define SHOW_DEFINE(x) printf("%s=%s\n", #x, STR(x))

#define INPUT_PTR_WIDTH 32 // make sure its power of 2 >_<
#define OUTPUT_PTR_WIDTH 32 // make sure its power of 2
#define HEIGHT 1920
#define WIDTH 1080
#define IN_TYPE XF_8UC3
#define OUT_TYPE XF_8UC3
#define NPPCX XF_NPPC1
#define XF_CV_DEPTH_IN 2
#define XF_CV_DEPTH_OUT 2

#define TNAME XF_TNAME(IN_TYPE,NPPCX)

static constexpr int __XF_DEPTH = (HEIGHT * WIDTH * (XF_PIXELWIDTH(IN_TYPE, NPPCX)) / 8) / (INPUT_PTR_WIDTH / 8);


void xf_cv_subtract(ap_uint<INPUT_PTR_WIDTH>* img_in1,
         ap_uint<INPUT_PTR_WIDTH>* img_in2,
         ap_uint<INPUT_PTR_WIDTH>* img_out);