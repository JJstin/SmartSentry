#include <iostream>

#include "core/xf_arithm.hpp"
#include "common/xf_headers.hpp"

#include "bg_sub.hpp"
#include "test.hpp"

#define NUM_TRANS 1



int main () { 
    //Establish an initial return value. 0 = success
    int ret=0;

    std::string img1_n = "./captured_frames/frame_6000.jpg";
    std::string img2_n = "./captured_frames/frame_12000.jpg";
    std::string cv_sub = "./captured_frames/diff_cv_6000_12000.jpg";
    std::string hls_sub = "./captured_frames/diff_hls_6000_12000.jpg";

    // std::string img1_n = "./captured_frames/128x128.png";
    // std::string img2_n = "./captured_frames/128x128.png";
    // std::string cv_sub = "./captured_frames/diff_cv_128x128.jpg";
    // std::string hls_sub = "./captured_frames/diff_hls_128x128.jpg";

    cv::Mat img1 = cv::imread(img1_n,1);
    cv::Mat img2 = cv::imread(img2_n,1);
    cv::Mat res;
    std::cout << "values read 0" << std::endl;
    std::cout << img1.rows << "x" << img1.cols <<std::endl;
    std::cout << img1.type() << std::endl;
    std::cout << "calling cv subtract" << std::endl;
    cv::subtract(img1,img2, res);
    std::cout << "cv subtract done" << std::endl;
    cv::Mat hls_res;
    hls_res.create(img1.rows, img1.cols, img1.type());
    std::cout << "Size of img1 data buffer: " << img1.total() * img1.elemSize() << std::endl;
    std::cout << "Depth of img1: " << img1.depth() << std::endl;
    std::cout << "Size of img2 data buffer: " << img2.total() * img2.elemSize() << std::endl;
    std::cout << "Depth of img2: " << img2.depth() << std::endl;
    std::cout << "Size of hls_res data buffer: " << hls_res.total() * hls_res.elemSize() << std::endl;
    std::cout << "Size of xf_cv_subtract port: " << __XF_DEPTH << std::endl;
    std::cout << "Bit depth of xf_cv_subtract: " << XF_CV_DEPTH_IN << std::endl;
    // Call any preliminary functions required to prepare input for the test.
    
    // Call the top-level function multiple times, passing input stimuli as needed.
    //   for(int i=0; i<NUM_TRANS; i++){
    //      top_func(input, output);
    //   }

    // Capture the output results of the function, write to a file
    
    // Compare the results of the function against expected results
    //   ret = system("diff --brief  -w output.dat output.golden.dat");
    
    std::cout << "caling xf_cv_subtract" << std::endl;
    bg_sub((ap_uint<INPUT_PTR_WIDTH>*)img1.data,(ap_uint<INPUT_PTR_WIDTH>*)img2.data, (ap_uint<OUTPUT_PTR_WIDTH>*)hls_res.data);
    std::cout << "xf_cv_subtract done" << std::endl; 

    cv::imwrite(cv_sub,res);
    
    cv::imwrite(hls_sub,hls_res);

    cv::Mat diff;
    cv::absdiff(res, hls_res, diff);
    cv::imwrite("diff.png", diff);

    // Find minimum and maximum differences.
    float err_per;
    xf::cv::analyzeDiff(diff, 0, err_per);

    if (err_per > 0.0f) {
            printf("Test failed  !!!\n"); 
            ret=1;
            std::cout << "Test passed !" << std::endl;
    } else {
            printf("Test passed !\n"); 
            std::cout << "Test passed !" << std::endl;
    }
    
    return ret;
}