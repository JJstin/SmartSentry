// ==============================================================
// Generated by Vitis HLS v2024.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module xf_cv_subtract_Array2xfMat_32_16_1920_1080_1_2_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        m_axi_gmem1_AWVALID,
        m_axi_gmem1_AWREADY,
        m_axi_gmem1_AWADDR,
        m_axi_gmem1_AWID,
        m_axi_gmem1_AWLEN,
        m_axi_gmem1_AWSIZE,
        m_axi_gmem1_AWBURST,
        m_axi_gmem1_AWLOCK,
        m_axi_gmem1_AWCACHE,
        m_axi_gmem1_AWPROT,
        m_axi_gmem1_AWQOS,
        m_axi_gmem1_AWREGION,
        m_axi_gmem1_AWUSER,
        m_axi_gmem1_WVALID,
        m_axi_gmem1_WREADY,
        m_axi_gmem1_WDATA,
        m_axi_gmem1_WSTRB,
        m_axi_gmem1_WLAST,
        m_axi_gmem1_WID,
        m_axi_gmem1_WUSER,
        m_axi_gmem1_ARVALID,
        m_axi_gmem1_ARREADY,
        m_axi_gmem1_ARADDR,
        m_axi_gmem1_ARID,
        m_axi_gmem1_ARLEN,
        m_axi_gmem1_ARSIZE,
        m_axi_gmem1_ARBURST,
        m_axi_gmem1_ARLOCK,
        m_axi_gmem1_ARCACHE,
        m_axi_gmem1_ARPROT,
        m_axi_gmem1_ARQOS,
        m_axi_gmem1_ARREGION,
        m_axi_gmem1_ARUSER,
        m_axi_gmem1_RVALID,
        m_axi_gmem1_RREADY,
        m_axi_gmem1_RDATA,
        m_axi_gmem1_RLAST,
        m_axi_gmem1_RID,
        m_axi_gmem1_RFIFONUM,
        m_axi_gmem1_RUSER,
        m_axi_gmem1_RRESP,
        m_axi_gmem1_BVALID,
        m_axi_gmem1_BREADY,
        m_axi_gmem1_BRESP,
        m_axi_gmem1_BID,
        m_axi_gmem1_BUSER,
        srcPtr,
        imgInput2_data_din,
        imgInput2_data_num_data_valid,
        imgInput2_data_fifo_cap,
        imgInput2_data_full_n,
        imgInput2_data_write
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   m_axi_gmem1_AWVALID;
input   m_axi_gmem1_AWREADY;
output  [63:0] m_axi_gmem1_AWADDR;
output  [0:0] m_axi_gmem1_AWID;
output  [31:0] m_axi_gmem1_AWLEN;
output  [2:0] m_axi_gmem1_AWSIZE;
output  [1:0] m_axi_gmem1_AWBURST;
output  [1:0] m_axi_gmem1_AWLOCK;
output  [3:0] m_axi_gmem1_AWCACHE;
output  [2:0] m_axi_gmem1_AWPROT;
output  [3:0] m_axi_gmem1_AWQOS;
output  [3:0] m_axi_gmem1_AWREGION;
output  [0:0] m_axi_gmem1_AWUSER;
output   m_axi_gmem1_WVALID;
input   m_axi_gmem1_WREADY;
output  [31:0] m_axi_gmem1_WDATA;
output  [3:0] m_axi_gmem1_WSTRB;
output   m_axi_gmem1_WLAST;
output  [0:0] m_axi_gmem1_WID;
output  [0:0] m_axi_gmem1_WUSER;
output   m_axi_gmem1_ARVALID;
input   m_axi_gmem1_ARREADY;
output  [63:0] m_axi_gmem1_ARADDR;
output  [0:0] m_axi_gmem1_ARID;
output  [31:0] m_axi_gmem1_ARLEN;
output  [2:0] m_axi_gmem1_ARSIZE;
output  [1:0] m_axi_gmem1_ARBURST;
output  [1:0] m_axi_gmem1_ARLOCK;
output  [3:0] m_axi_gmem1_ARCACHE;
output  [2:0] m_axi_gmem1_ARPROT;
output  [3:0] m_axi_gmem1_ARQOS;
output  [3:0] m_axi_gmem1_ARREGION;
output  [0:0] m_axi_gmem1_ARUSER;
input   m_axi_gmem1_RVALID;
output   m_axi_gmem1_RREADY;
input  [31:0] m_axi_gmem1_RDATA;
input   m_axi_gmem1_RLAST;
input  [0:0] m_axi_gmem1_RID;
input  [8:0] m_axi_gmem1_RFIFONUM;
input  [0:0] m_axi_gmem1_RUSER;
input  [1:0] m_axi_gmem1_RRESP;
input   m_axi_gmem1_BVALID;
output   m_axi_gmem1_BREADY;
input  [1:0] m_axi_gmem1_BRESP;
input  [0:0] m_axi_gmem1_BID;
input  [0:0] m_axi_gmem1_BUSER;
input  [63:0] srcPtr;
output  [23:0] imgInput2_data_din;
input  [2:0] imgInput2_data_num_data_valid;
input  [2:0] imgInput2_data_fifo_cap;
input   imgInput2_data_full_n;
output   imgInput2_data_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg m_axi_gmem1_ARVALID;
reg m_axi_gmem1_RREADY;
reg imgInput2_data_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_block_state1;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_AWVALID;
wire   [63:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWADDR;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWID;
wire   [31:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWLEN;
wire   [2:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWSIZE;
wire   [1:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWBURST;
wire   [1:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWLOCK;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWCACHE;
wire   [2:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWPROT;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWQOS;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWREGION;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_AWUSER;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_WVALID;
wire   [31:0] grp_Axi2Mat_fu_36_m_axi_gmem1_WDATA;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_WSTRB;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_WLAST;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_WID;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_WUSER;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_ARVALID;
wire   [63:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARADDR;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARID;
wire   [31:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARLEN;
wire   [2:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARSIZE;
wire   [1:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARBURST;
wire   [1:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARLOCK;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARCACHE;
wire   [2:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARPROT;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARQOS;
wire   [3:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARREGION;
wire   [0:0] grp_Axi2Mat_fu_36_m_axi_gmem1_ARUSER;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_RREADY;
wire    grp_Axi2Mat_fu_36_m_axi_gmem1_BREADY;
wire   [23:0] grp_Axi2Mat_fu_36_imgInput2_data_din;
wire    grp_Axi2Mat_fu_36_imgInput2_data_write;
wire    grp_Axi2Mat_fu_36_ap_start;
wire    grp_Axi2Mat_fu_36_ap_done;
wire    grp_Axi2Mat_fu_36_ap_ready;
wire    grp_Axi2Mat_fu_36_ap_idle;
reg    grp_Axi2Mat_fu_36_ap_continue;
reg    grp_Axi2Mat_fu_36_ap_start_reg;
reg    ap_block_state1_ignore_call3;
wire    ap_CS_fsm_state2;
reg    ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready;
reg    ap_sync_reg_grp_Axi2Mat_fu_36_ap_done;
reg    ap_block_state2_on_subcall_done;
wire    ap_sync_grp_Axi2Mat_fu_36_ap_ready;
reg   [1:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_Axi2Mat_fu_36_ap_start_reg = 1'b0;
#0 ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready = 1'b0;
#0 ap_sync_reg_grp_Axi2Mat_fu_36_ap_done = 1'b0;
end

xf_cv_subtract_Axi2Mat grp_Axi2Mat_fu_36(
    .m_axi_gmem1_AWVALID(grp_Axi2Mat_fu_36_m_axi_gmem1_AWVALID),
    .m_axi_gmem1_AWREADY(1'b0),
    .m_axi_gmem1_AWADDR(grp_Axi2Mat_fu_36_m_axi_gmem1_AWADDR),
    .m_axi_gmem1_AWID(grp_Axi2Mat_fu_36_m_axi_gmem1_AWID),
    .m_axi_gmem1_AWLEN(grp_Axi2Mat_fu_36_m_axi_gmem1_AWLEN),
    .m_axi_gmem1_AWSIZE(grp_Axi2Mat_fu_36_m_axi_gmem1_AWSIZE),
    .m_axi_gmem1_AWBURST(grp_Axi2Mat_fu_36_m_axi_gmem1_AWBURST),
    .m_axi_gmem1_AWLOCK(grp_Axi2Mat_fu_36_m_axi_gmem1_AWLOCK),
    .m_axi_gmem1_AWCACHE(grp_Axi2Mat_fu_36_m_axi_gmem1_AWCACHE),
    .m_axi_gmem1_AWPROT(grp_Axi2Mat_fu_36_m_axi_gmem1_AWPROT),
    .m_axi_gmem1_AWQOS(grp_Axi2Mat_fu_36_m_axi_gmem1_AWQOS),
    .m_axi_gmem1_AWREGION(grp_Axi2Mat_fu_36_m_axi_gmem1_AWREGION),
    .m_axi_gmem1_AWUSER(grp_Axi2Mat_fu_36_m_axi_gmem1_AWUSER),
    .m_axi_gmem1_WVALID(grp_Axi2Mat_fu_36_m_axi_gmem1_WVALID),
    .m_axi_gmem1_WREADY(1'b0),
    .m_axi_gmem1_WDATA(grp_Axi2Mat_fu_36_m_axi_gmem1_WDATA),
    .m_axi_gmem1_WSTRB(grp_Axi2Mat_fu_36_m_axi_gmem1_WSTRB),
    .m_axi_gmem1_WLAST(grp_Axi2Mat_fu_36_m_axi_gmem1_WLAST),
    .m_axi_gmem1_WID(grp_Axi2Mat_fu_36_m_axi_gmem1_WID),
    .m_axi_gmem1_WUSER(grp_Axi2Mat_fu_36_m_axi_gmem1_WUSER),
    .m_axi_gmem1_ARVALID(grp_Axi2Mat_fu_36_m_axi_gmem1_ARVALID),
    .m_axi_gmem1_ARREADY(m_axi_gmem1_ARREADY),
    .m_axi_gmem1_ARADDR(grp_Axi2Mat_fu_36_m_axi_gmem1_ARADDR),
    .m_axi_gmem1_ARID(grp_Axi2Mat_fu_36_m_axi_gmem1_ARID),
    .m_axi_gmem1_ARLEN(grp_Axi2Mat_fu_36_m_axi_gmem1_ARLEN),
    .m_axi_gmem1_ARSIZE(grp_Axi2Mat_fu_36_m_axi_gmem1_ARSIZE),
    .m_axi_gmem1_ARBURST(grp_Axi2Mat_fu_36_m_axi_gmem1_ARBURST),
    .m_axi_gmem1_ARLOCK(grp_Axi2Mat_fu_36_m_axi_gmem1_ARLOCK),
    .m_axi_gmem1_ARCACHE(grp_Axi2Mat_fu_36_m_axi_gmem1_ARCACHE),
    .m_axi_gmem1_ARPROT(grp_Axi2Mat_fu_36_m_axi_gmem1_ARPROT),
    .m_axi_gmem1_ARQOS(grp_Axi2Mat_fu_36_m_axi_gmem1_ARQOS),
    .m_axi_gmem1_ARREGION(grp_Axi2Mat_fu_36_m_axi_gmem1_ARREGION),
    .m_axi_gmem1_ARUSER(grp_Axi2Mat_fu_36_m_axi_gmem1_ARUSER),
    .m_axi_gmem1_RVALID(m_axi_gmem1_RVALID),
    .m_axi_gmem1_RREADY(grp_Axi2Mat_fu_36_m_axi_gmem1_RREADY),
    .m_axi_gmem1_RDATA(m_axi_gmem1_RDATA),
    .m_axi_gmem1_RLAST(m_axi_gmem1_RLAST),
    .m_axi_gmem1_RID(m_axi_gmem1_RID),
    .m_axi_gmem1_RFIFONUM(m_axi_gmem1_RFIFONUM),
    .m_axi_gmem1_RUSER(m_axi_gmem1_RUSER),
    .m_axi_gmem1_RRESP(m_axi_gmem1_RRESP),
    .m_axi_gmem1_BVALID(1'b0),
    .m_axi_gmem1_BREADY(grp_Axi2Mat_fu_36_m_axi_gmem1_BREADY),
    .m_axi_gmem1_BRESP(2'd0),
    .m_axi_gmem1_BID(1'd0),
    .m_axi_gmem1_BUSER(1'd0),
    .din(srcPtr),
    .imgInput2_data_din(grp_Axi2Mat_fu_36_imgInput2_data_din),
    .imgInput2_data_full_n(imgInput2_data_full_n),
    .imgInput2_data_write(grp_Axi2Mat_fu_36_imgInput2_data_write),
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .din_ap_vld(1'b1),
    .ap_start(grp_Axi2Mat_fu_36_ap_start),
    .ap_done(grp_Axi2Mat_fu_36_ap_done),
    .ap_ready(grp_Axi2Mat_fu_36_ap_ready),
    .ap_idle(grp_Axi2Mat_fu_36_ap_idle),
    .ap_continue(grp_Axi2Mat_fu_36_ap_continue)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_grp_Axi2Mat_fu_36_ap_done <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_sync_reg_grp_Axi2Mat_fu_36_ap_done <= 1'b0;
        end else if ((grp_Axi2Mat_fu_36_ap_done == 1'b1)) begin
            ap_sync_reg_grp_Axi2Mat_fu_36_ap_done <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready <= 1'b0;
        end else if ((grp_Axi2Mat_fu_36_ap_ready == 1'b1)) begin
            ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_Axi2Mat_fu_36_ap_start_reg <= 1'b0;
    end else begin
        if ((((1'b1 == ap_CS_fsm_state2) & (ap_sync_grp_Axi2Mat_fu_36_ap_ready == 1'b0)) | ((1'b0 == ap_block_state1_ignore_call3) & (1'b1 == ap_CS_fsm_state1)))) begin
            grp_Axi2Mat_fu_36_ap_start_reg <= 1'b1;
        end else if ((grp_Axi2Mat_fu_36_ap_ready == 1'b1)) begin
            grp_Axi2Mat_fu_36_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if ((1'b1 == ap_block_state1)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_block_state2_on_subcall_done)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
        grp_Axi2Mat_fu_36_ap_continue = 1'b1;
    end else begin
        grp_Axi2Mat_fu_36_ap_continue = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        imgInput2_data_write = grp_Axi2Mat_fu_36_imgInput2_data_write;
    end else begin
        imgInput2_data_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        m_axi_gmem1_ARVALID = grp_Axi2Mat_fu_36_m_axi_gmem1_ARVALID;
    end else begin
        m_axi_gmem1_ARVALID = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        m_axi_gmem1_RREADY = grp_Axi2Mat_fu_36_m_axi_gmem1_RREADY;
    end else begin
        m_axi_gmem1_RREADY = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b0 == ap_block_state1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b0 == ap_block_state2_on_subcall_done) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call3 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2_on_subcall_done = ((ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready & ap_sync_reg_grp_Axi2Mat_fu_36_ap_done) == 1'b0);
end

assign ap_sync_grp_Axi2Mat_fu_36_ap_ready = (grp_Axi2Mat_fu_36_ap_ready | ap_sync_reg_grp_Axi2Mat_fu_36_ap_ready);

assign grp_Axi2Mat_fu_36_ap_start = grp_Axi2Mat_fu_36_ap_start_reg;

assign imgInput2_data_din = grp_Axi2Mat_fu_36_imgInput2_data_din;

assign m_axi_gmem1_ARADDR = grp_Axi2Mat_fu_36_m_axi_gmem1_ARADDR;

assign m_axi_gmem1_ARBURST = grp_Axi2Mat_fu_36_m_axi_gmem1_ARBURST;

assign m_axi_gmem1_ARCACHE = grp_Axi2Mat_fu_36_m_axi_gmem1_ARCACHE;

assign m_axi_gmem1_ARID = grp_Axi2Mat_fu_36_m_axi_gmem1_ARID;

assign m_axi_gmem1_ARLEN = grp_Axi2Mat_fu_36_m_axi_gmem1_ARLEN;

assign m_axi_gmem1_ARLOCK = grp_Axi2Mat_fu_36_m_axi_gmem1_ARLOCK;

assign m_axi_gmem1_ARPROT = grp_Axi2Mat_fu_36_m_axi_gmem1_ARPROT;

assign m_axi_gmem1_ARQOS = grp_Axi2Mat_fu_36_m_axi_gmem1_ARQOS;

assign m_axi_gmem1_ARREGION = grp_Axi2Mat_fu_36_m_axi_gmem1_ARREGION;

assign m_axi_gmem1_ARSIZE = grp_Axi2Mat_fu_36_m_axi_gmem1_ARSIZE;

assign m_axi_gmem1_ARUSER = grp_Axi2Mat_fu_36_m_axi_gmem1_ARUSER;

assign m_axi_gmem1_AWADDR = 64'd0;

assign m_axi_gmem1_AWBURST = 2'd0;

assign m_axi_gmem1_AWCACHE = 4'd0;

assign m_axi_gmem1_AWID = 1'd0;

assign m_axi_gmem1_AWLEN = 32'd0;

assign m_axi_gmem1_AWLOCK = 2'd0;

assign m_axi_gmem1_AWPROT = 3'd0;

assign m_axi_gmem1_AWQOS = 4'd0;

assign m_axi_gmem1_AWREGION = 4'd0;

assign m_axi_gmem1_AWSIZE = 3'd0;

assign m_axi_gmem1_AWUSER = 1'd0;

assign m_axi_gmem1_AWVALID = 1'b0;

assign m_axi_gmem1_BREADY = 1'b0;

assign m_axi_gmem1_WDATA = 32'd0;

assign m_axi_gmem1_WID = 1'd0;

assign m_axi_gmem1_WLAST = 1'b0;

assign m_axi_gmem1_WSTRB = 4'd0;

assign m_axi_gmem1_WUSER = 1'd0;

assign m_axi_gmem1_WVALID = 1'b0;

endmodule //xf_cv_subtract_Array2xfMat_32_16_1920_1080_1_2_1
