#include "core/xf_arithm.hpp"
#define INPUT_PTR_WIDTH 32 // make sure its power of 2 >_<
#define OUTPUT_PTR_WIDTH 32 // make sure its power of 2
#define UCHAR_PTR_WIDTH 8

#define HEIGHT 1920
#define WIDTH 1080
#define NMIXTURES 5
#define NCHANNELS 3

#define IN_TYPE XF_8UC3
#define OUT_TYPE XF_8UC3
#define NPPCX XF_NPPC1
#define XF_CV_DEPTH_IN 2
#define XF_CV_DEPTH_OUT 2

static constexpr int __XF_DEPTH = (HEIGHT * WIDTH * (XF_PIXELWIDTH(IN_TYPE, NPPCX)) / 8) / (INPUT_PTR_WIDTH / 8);

static constexpr int __BG_MODEL_DEPTH = (HEIGHT * WIDTH* NMIXTURES * (2 + NCHANNELS)) / (32 / 8);




void bg_sub(ap_uint<INPUT_PTR_WIDTH>* src,
        ap_uint<INPUT_PTR_WIDTH>* dst,
        float gmm_weight,
        float gmm_variance,
        float* mean0,
        ap_uint<UCHAR_PTR_WIDTH>* modesUsed0,
        int nmixtures,
        float alphaT, float Tb, float TB, float Tg,
        float varInit, float varMin, float varMax, float prune, float tau,
        bool detectShadows,
        ap_uint<UCHAR_PTR_WIDTH> shadowVal
        );