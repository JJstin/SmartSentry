/*
 * Generated by Vitis IDE
 * Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
 * Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
 */

/**
 * @file xf_cv_subtract.cpp
 *
 * @brief Instantiation wrapper for xf_cv_subtract function generated on 14/07/2024, 23:59:19
 */

#include "core/xf_arithm.hpp"
#include "common/xf_common.hpp"
#include "common/xf_utility.hpp"

#include "xf_cv_subtract.hpp"

// static constexpr int __XF_DEPTH = (HEIGHT * WIDTH * (XF_PIXELWIDTH(IN_TYPE, NPPCX)) / 8) / (INPUT_PTR_WIDTH / 8);

void xf_cv_subtract(ap_uint<INPUT_PTR_WIDTH>* img_in1,
         ap_uint<INPUT_PTR_WIDTH>* img_in2,
         ap_uint<INPUT_PTR_WIDTH>* img_out) {
    // TODO: add interface pragma(s) here
    // clang-format off
    #pragma HLS INTERFACE mode=m_axi port=img_in1 offset=slave bundle=gmem0 depth=__XF_DEPTH
    #pragma HLS INTERFACE mode=m_axi port=img_in2 offset=slave bundle=gmem1 depth=__XF_DEPTH
    #pragma HLS INTERFACE mode=m_axi port=img_out offset=slave bundle=gmem2 depth=__XF_DEPTH
    #pragma HLS INTERFACE s_axilite  port=return
    // clang-format on

    xf::cv::Mat< IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN> imgInput1(HEIGHT, WIDTH);
    xf::cv::Mat< IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN> imgInput2(HEIGHT, WIDTH);
    xf::cv::Mat< IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN> imgOutput(HEIGHT, WIDTH);

    // clang-format off
    #pragma HLS DATAFLOW
    // clang-format on
    xf::cv::Array2xfMat<INPUT_PTR_WIDTH, IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN>(img_in1, imgInput1);
    xf::cv::Array2xfMat<INPUT_PTR_WIDTH, IN_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_IN>(img_in2, imgInput2);
    
    xf::cv::subtract<XF_CONVERT_POLICY_SATURATE, IN_TYPE, HEIGHT, WIDTH, XF_NPPC1, XF_CV_DEPTH_IN, XF_CV_DEPTH_IN, XF_CV_DEPTH_OUT>(imgInput1, imgInput2, imgOutput);

    xf::cv::xfMat2Array<OUTPUT_PTR_WIDTH, OUT_TYPE, HEIGHT, WIDTH, NPPCX, XF_CV_DEPTH_OUT>(imgOutput, img_out);
    return;
}