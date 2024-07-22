set SynModuleInfo {
  {SRCNAME entry_proc1 MODELNAME entry_proc1 RTLNAME xf_cv_subtract_entry_proc1}
  {SRCNAME Axi2AxiStream_Pipeline_VITIS_LOOP_1021_1 MODELNAME Axi2AxiStream_Pipeline_VITIS_LOOP_1021_1 RTLNAME xf_cv_subtract_Axi2AxiStream_Pipeline_VITIS_LOOP_1021_1
    SUBMODULES {
      {MODELNAME xf_cv_subtract_flow_control_loop_pipe_sequential_init RTLNAME xf_cv_subtract_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME xf_cv_subtract_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME Axi2AxiStream MODELNAME Axi2AxiStream RTLNAME xf_cv_subtract_Axi2AxiStream}
  {SRCNAME AxiStream2MatStream<2> MODELNAME AxiStream2MatStream_2_s RTLNAME xf_cv_subtract_AxiStream2MatStream_2_s
    SUBMODULES {
      {MODELNAME xf_cv_subtract_flow_control_loop_delay_pipe RTLNAME xf_cv_subtract_flow_control_loop_delay_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME xf_cv_subtract_flow_control_loop_delay_pipe_U}
    }
  }
  {SRCNAME AxiStream2Mat MODELNAME AxiStream2Mat RTLNAME xf_cv_subtract_AxiStream2Mat}
  {SRCNAME Axi2Mat MODELNAME Axi2Mat RTLNAME xf_cv_subtract_Axi2Mat
    SUBMODULES {
      {MODELNAME xf_cv_subtract_fifo_w32_d2_S RTLNAME xf_cv_subtract_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME ldata_U}
      {MODELNAME xf_cv_subtract_start_for_AxiStream2Mat_U0 RTLNAME xf_cv_subtract_start_for_AxiStream2Mat_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_AxiStream2Mat_U0_U}
    }
  }
  {SRCNAME {Array2xfMat<32, 16, 1920, 1080, 1, 2>} MODELNAME Array2xfMat_32_16_1920_1080_1_2_s RTLNAME xf_cv_subtract_Array2xfMat_32_16_1920_1080_1_2_s}
  {SRCNAME {Array2xfMat<32, 16, 1920, 1080, 1, 2>.1} MODELNAME Array2xfMat_32_16_1920_1080_1_2_1 RTLNAME xf_cv_subtract_Array2xfMat_32_16_1920_1080_1_2_1}
  {SRCNAME {subtract<0, 16, 1920, 1080, 1, 2, 2, 2>_Pipeline_colLoop} MODELNAME subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop RTLNAME xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop}
  {SRCNAME {subtract<0, 16, 1920, 1080, 1, 2, 2, 2>} MODELNAME subtract_0_16_1920_1080_1_2_2_2_s RTLNAME xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_s}
  {SRCNAME entry_proc MODELNAME entry_proc RTLNAME xf_cv_subtract_entry_proc}
  {SRCNAME MatStream2AxiStream<2>_Pipeline_MMIterOutRow_MMIterOutCol MODELNAME MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol RTLNAME xf_cv_subtract_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol}
  {SRCNAME MatStream2AxiStream<2> MODELNAME MatStream2AxiStream_2_s RTLNAME xf_cv_subtract_MatStream2AxiStream_2_s}
  {SRCNAME Mat2AxiStream MODELNAME Mat2AxiStream RTLNAME xf_cv_subtract_Mat2AxiStream}
  {SRCNAME AxiStream2Axi_Pipeline_MMIterOutLoop2 MODELNAME AxiStream2Axi_Pipeline_MMIterOutLoop2 RTLNAME xf_cv_subtract_AxiStream2Axi_Pipeline_MMIterOutLoop2}
  {SRCNAME AxiStream2Axi MODELNAME AxiStream2Axi RTLNAME xf_cv_subtract_AxiStream2Axi}
  {SRCNAME Mat2Axi MODELNAME Mat2Axi RTLNAME xf_cv_subtract_Mat2Axi
    SUBMODULES {
      {MODELNAME xf_cv_subtract_fifo_w64_d3_S RTLNAME xf_cv_subtract_fifo_w64_d3_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME dout_c_U}
      {MODELNAME xf_cv_subtract_fifo_w32_d2_S_x RTLNAME xf_cv_subtract_fifo_w32_d2_S_x BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME ldata_U}
      {MODELNAME xf_cv_subtract_start_for_AxiStream2Axi_U0 RTLNAME xf_cv_subtract_start_for_AxiStream2Axi_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_AxiStream2Axi_U0_U}
    }
  }
  {SRCNAME {xfMat2Array<32, 16, 1920, 1080, 1, 2, 1>} MODELNAME xfMat2Array_32_16_1920_1080_1_2_1_s RTLNAME xf_cv_subtract_xfMat2Array_32_16_1920_1080_1_2_1_s}
  {SRCNAME xf_cv_subtract MODELNAME xf_cv_subtract RTLNAME xf_cv_subtract IS_TOP 1
    SUBMODULES {
      {MODELNAME xf_cv_subtract_fifo_w64_d4_S RTLNAME xf_cv_subtract_fifo_w64_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME img_out_c_U}
      {MODELNAME xf_cv_subtract_fifo_w24_d2_S RTLNAME xf_cv_subtract_fifo_w24_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME imgInput1_data_U}
      {MODELNAME xf_cv_subtract_fifo_w24_d2_S RTLNAME xf_cv_subtract_fifo_w24_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME imgInput2_data_U}
      {MODELNAME xf_cv_subtract_fifo_w24_d2_S RTLNAME xf_cv_subtract_fifo_w24_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME imgOutput_data_U}
      {MODELNAME xf_cv_subtract_start_for_xfMat2Array_32_16_1920_1080_1_2_1_U0 RTLNAME xf_cv_subtract_start_for_xfMat2Array_32_16_1920_1080_1_2_1_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_xfMat2Array_32_16_1920_1080_1_2_1_U0_U}
      {MODELNAME xf_cv_subtract_start_for_subtract_0_16_1920_1080_1_2_2_2_U0 RTLNAME xf_cv_subtract_start_for_subtract_0_16_1920_1080_1_2_2_2_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_subtract_0_16_1920_1080_1_2_2_2_U0_U}
      {MODELNAME xf_cv_subtract_gmem0_m_axi RTLNAME xf_cv_subtract_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME xf_cv_subtract_gmem1_m_axi RTLNAME xf_cv_subtract_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME xf_cv_subtract_gmem2_m_axi RTLNAME xf_cv_subtract_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME xf_cv_subtract_control_s_axi RTLNAME xf_cv_subtract_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
