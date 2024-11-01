// ==============================================================
// Generated by Vitis HLS v2024.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        imgInput1_data_dout,
        imgInput1_data_num_data_valid,
        imgInput1_data_fifo_cap,
        imgInput1_data_empty_n,
        imgInput1_data_read,
        imgInput2_data_dout,
        imgInput2_data_num_data_valid,
        imgInput2_data_fifo_cap,
        imgInput2_data_empty_n,
        imgInput2_data_read,
        imgOutput_data_din,
        imgOutput_data_num_data_valid,
        imgOutput_data_fifo_cap,
        imgOutput_data_full_n,
        imgOutput_data_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [23:0] imgInput1_data_dout;
input  [2:0] imgInput1_data_num_data_valid;
input  [2:0] imgInput1_data_fifo_cap;
input   imgInput1_data_empty_n;
output   imgInput1_data_read;
input  [23:0] imgInput2_data_dout;
input  [2:0] imgInput2_data_num_data_valid;
input  [2:0] imgInput2_data_fifo_cap;
input   imgInput2_data_empty_n;
output   imgInput2_data_read;
output  [23:0] imgOutput_data_din;
input  [2:0] imgOutput_data_num_data_valid;
input  [2:0] imgOutput_data_fifo_cap;
input   imgOutput_data_full_n;
output   imgOutput_data_write;

reg ap_idle;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln827_fu_85_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    imgInput1_data_blk_n;
wire    ap_block_pp0_stage0;
reg    imgInput2_data_blk_n;
reg    imgOutput_data_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [7:0] select_ln851_fu_136_p3;
reg   [7:0] select_ln851_reg_271;
wire   [7:0] select_ln851_1_fu_190_p3;
reg   [7:0] select_ln851_1_reg_276;
wire   [7:0] select_ln851_2_fu_244_p3;
reg   [7:0] select_ln851_2_reg_281;
reg   [10:0] j_fu_54;
wire   [10:0] j_2_fu_91_p2;
wire    ap_loop_init;
reg   [10:0] ap_sig_allocacmp_j_1;
reg    imgInput1_data_read_local;
reg    imgInput2_data_read_local;
wire   [23:0] val_dst_fu_252_p4;
reg    ap_block_pp0_stage0_01001;
reg    imgOutput_data_write_local;
wire   [7:0] trunc_ln842_fu_102_p1;
wire   [7:0] trunc_ln844_fu_106_p1;
wire   [8:0] zext_ln74_fu_110_p1;
wire   [8:0] zext_ln74_1_fu_114_p1;
wire   [8:0] result_temp_fu_118_p2;
wire   [0:0] tmp_fu_124_p3;
wire   [7:0] trunc_ln851_fu_132_p1;
wire   [7:0] tmp_s_fu_144_p4;
wire   [7:0] tmp_1_fu_154_p4;
wire   [8:0] zext_ln74_2_fu_164_p1;
wire   [8:0] zext_ln74_3_fu_168_p1;
wire   [8:0] result_temp_1_fu_172_p2;
wire   [0:0] tmp_2_fu_178_p3;
wire   [7:0] trunc_ln851_1_fu_186_p1;
wire   [7:0] tmp_3_fu_198_p4;
wire   [7:0] tmp_4_fu_208_p4;
wire   [8:0] zext_ln74_4_fu_218_p1;
wire   [8:0] zext_ln74_5_fu_222_p1;
wire   [8:0] result_temp_2_fu_226_p2;
wire   [0:0] tmp_5_fu_232_p3;
wire   [7:0] trunc_ln851_2_fu_240_p1;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ready_sig;
wire    ap_done_sig;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 j_fu_54 = 11'd0;
#0 ap_done_reg = 1'b0;
end

xf_cv_subtract_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready_sig),
    .ap_done(ap_done_sig),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln827_fu_85_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            j_fu_54 <= j_2_fu_91_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            j_fu_54 <= 11'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        select_ln851_1_reg_276 <= select_ln851_1_fu_190_p3;
        select_ln851_2_reg_281 <= select_ln851_2_fu_244_p3;
        select_ln851_reg_271 <= select_ln851_fu_136_p3;
    end
end

always @ (*) begin
    if (((icmp_ln827_fu_85_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_j_1 = 11'd0;
    end else begin
        ap_sig_allocacmp_j_1 = j_fu_54;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput1_data_blk_n = imgInput1_data_empty_n;
    end else begin
        imgInput1_data_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput1_data_read_local = 1'b1;
    end else begin
        imgInput1_data_read_local = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput2_data_blk_n = imgInput2_data_empty_n;
    end else begin
        imgInput2_data_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        imgInput2_data_read_local = 1'b1;
    end else begin
        imgInput2_data_read_local = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        imgOutput_data_blk_n = imgOutput_data_full_n;
    end else begin
        imgOutput_data_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        imgOutput_data_write_local = 1'b1;
    end else begin
        imgOutput_data_write_local = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_block_state3_pp0_stage0_iter2)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_block_state3_pp0_stage0_iter2)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_block_state3_pp0_stage0_iter2)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((imgInput2_data_empty_n == 1'b0) | (imgInput1_data_empty_n == 1'b0));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (imgOutput_data_full_n == 1'b0);
end

assign ap_done = ap_done_sig;

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign ap_ready = ap_ready_sig;

assign icmp_ln827_fu_85_p2 = ((ap_sig_allocacmp_j_1 == 11'd1080) ? 1'b1 : 1'b0);

assign imgInput1_data_read = imgInput1_data_read_local;

assign imgInput2_data_read = imgInput2_data_read_local;

assign imgOutput_data_din = val_dst_fu_252_p4;

assign imgOutput_data_write = imgOutput_data_write_local;

assign j_2_fu_91_p2 = (ap_sig_allocacmp_j_1 + 11'd1);

assign result_temp_1_fu_172_p2 = (zext_ln74_2_fu_164_p1 - zext_ln74_3_fu_168_p1);

assign result_temp_2_fu_226_p2 = (zext_ln74_4_fu_218_p1 - zext_ln74_5_fu_222_p1);

assign result_temp_fu_118_p2 = (zext_ln74_fu_110_p1 - zext_ln74_1_fu_114_p1);

assign select_ln851_1_fu_190_p3 = ((tmp_2_fu_178_p3[0:0] == 1'b1) ? 8'd0 : trunc_ln851_1_fu_186_p1);

assign select_ln851_2_fu_244_p3 = ((tmp_5_fu_232_p3[0:0] == 1'b1) ? 8'd0 : trunc_ln851_2_fu_240_p1);

assign select_ln851_fu_136_p3 = ((tmp_fu_124_p3[0:0] == 1'b1) ? 8'd0 : trunc_ln851_fu_132_p1);

assign tmp_1_fu_154_p4 = {{imgInput2_data_dout[15:8]}};

assign tmp_2_fu_178_p3 = result_temp_1_fu_172_p2[32'd8];

assign tmp_3_fu_198_p4 = {{imgInput1_data_dout[23:16]}};

assign tmp_4_fu_208_p4 = {{imgInput2_data_dout[23:16]}};

assign tmp_5_fu_232_p3 = result_temp_2_fu_226_p2[32'd8];

assign tmp_fu_124_p3 = result_temp_fu_118_p2[32'd8];

assign tmp_s_fu_144_p4 = {{imgInput1_data_dout[15:8]}};

assign trunc_ln842_fu_102_p1 = imgInput1_data_dout[7:0];

assign trunc_ln844_fu_106_p1 = imgInput2_data_dout[7:0];

assign trunc_ln851_1_fu_186_p1 = result_temp_1_fu_172_p2[7:0];

assign trunc_ln851_2_fu_240_p1 = result_temp_2_fu_226_p2[7:0];

assign trunc_ln851_fu_132_p1 = result_temp_fu_118_p2[7:0];

assign val_dst_fu_252_p4 = {{{select_ln851_2_reg_281}, {select_ln851_1_reg_276}}, {select_ln851_reg_271}};

assign zext_ln74_1_fu_114_p1 = trunc_ln844_fu_106_p1;

assign zext_ln74_2_fu_164_p1 = tmp_s_fu_144_p4;

assign zext_ln74_3_fu_168_p1 = tmp_1_fu_154_p4;

assign zext_ln74_4_fu_218_p1 = tmp_3_fu_198_p4;

assign zext_ln74_5_fu_222_p1 = tmp_4_fu_208_p4;

assign zext_ln74_fu_110_p1 = trunc_ln842_fu_102_p1;

endmodule //xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop
