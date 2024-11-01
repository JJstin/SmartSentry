// ==============================================================
// Generated by Vitis HLS v2024.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module xf_cv_subtract_Axi2Mat (
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
        din,
        imgInput2_data_din,
        imgInput2_data_full_n,
        imgInput2_data_write,
        ap_clk,
        ap_rst,
        din_ap_vld,
        ap_start,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


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
input  [63:0] din;
output  [23:0] imgInput2_data_din;
input   imgInput2_data_full_n;
output   imgInput2_data_write;
input   ap_clk;
input   ap_rst;
input   din_ap_vld;
input   ap_start;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire    Axi2AxiStream_U0_ap_start;
wire    Axi2AxiStream_U0_ap_done;
wire    Axi2AxiStream_U0_ap_continue;
wire    Axi2AxiStream_U0_ap_idle;
wire    Axi2AxiStream_U0_ap_ready;
wire    Axi2AxiStream_U0_start_out;
wire    Axi2AxiStream_U0_start_write;
wire    Axi2AxiStream_U0_m_axi_gmem0_AWVALID;
wire   [63:0] Axi2AxiStream_U0_m_axi_gmem0_AWADDR;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_AWID;
wire   [31:0] Axi2AxiStream_U0_m_axi_gmem0_AWLEN;
wire   [2:0] Axi2AxiStream_U0_m_axi_gmem0_AWSIZE;
wire   [1:0] Axi2AxiStream_U0_m_axi_gmem0_AWBURST;
wire   [1:0] Axi2AxiStream_U0_m_axi_gmem0_AWLOCK;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_AWCACHE;
wire   [2:0] Axi2AxiStream_U0_m_axi_gmem0_AWPROT;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_AWQOS;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_AWREGION;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_AWUSER;
wire    Axi2AxiStream_U0_m_axi_gmem0_WVALID;
wire   [31:0] Axi2AxiStream_U0_m_axi_gmem0_WDATA;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_WSTRB;
wire    Axi2AxiStream_U0_m_axi_gmem0_WLAST;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_WID;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_WUSER;
wire    Axi2AxiStream_U0_m_axi_gmem0_ARVALID;
wire   [63:0] Axi2AxiStream_U0_m_axi_gmem0_ARADDR;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_ARID;
wire   [31:0] Axi2AxiStream_U0_m_axi_gmem0_ARLEN;
wire   [2:0] Axi2AxiStream_U0_m_axi_gmem0_ARSIZE;
wire   [1:0] Axi2AxiStream_U0_m_axi_gmem0_ARBURST;
wire   [1:0] Axi2AxiStream_U0_m_axi_gmem0_ARLOCK;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_ARCACHE;
wire   [2:0] Axi2AxiStream_U0_m_axi_gmem0_ARPROT;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_ARQOS;
wire   [3:0] Axi2AxiStream_U0_m_axi_gmem0_ARREGION;
wire   [0:0] Axi2AxiStream_U0_m_axi_gmem0_ARUSER;
wire    Axi2AxiStream_U0_m_axi_gmem0_RREADY;
wire    Axi2AxiStream_U0_m_axi_gmem0_BREADY;
wire   [31:0] Axi2AxiStream_U0_ldata_din;
wire    Axi2AxiStream_U0_ldata_write;
wire    AxiStream2Mat_U0_ldata_read;
wire   [23:0] AxiStream2Mat_U0_imgInput1_data_din;
wire    AxiStream2Mat_U0_imgInput1_data_write;
wire    AxiStream2Mat_U0_ap_start;
wire    AxiStream2Mat_U0_ap_done;
wire    AxiStream2Mat_U0_ap_ready;
wire    AxiStream2Mat_U0_ap_idle;
wire    AxiStream2Mat_U0_ap_continue;
wire    ldata_full_n;
wire   [31:0] ldata_dout;
wire   [2:0] ldata_num_data_valid;
wire   [2:0] ldata_fifo_cap;
wire    ldata_empty_n;
wire   [0:0] start_for_AxiStream2Mat_U0_din;
wire    start_for_AxiStream2Mat_U0_full_n;
wire   [0:0] start_for_AxiStream2Mat_U0_dout;
wire    start_for_AxiStream2Mat_U0_empty_n;

xf_cv_subtract_Axi2AxiStream Axi2AxiStream_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2AxiStream_U0_ap_start),
    .start_full_n(start_for_AxiStream2Mat_U0_full_n),
    .ap_done(Axi2AxiStream_U0_ap_done),
    .ap_continue(Axi2AxiStream_U0_ap_continue),
    .ap_idle(Axi2AxiStream_U0_ap_idle),
    .ap_ready(Axi2AxiStream_U0_ap_ready),
    .start_out(Axi2AxiStream_U0_start_out),
    .start_write(Axi2AxiStream_U0_start_write),
    .m_axi_gmem0_AWVALID(Axi2AxiStream_U0_m_axi_gmem0_AWVALID),
    .m_axi_gmem0_AWREADY(1'b0),
    .m_axi_gmem0_AWADDR(Axi2AxiStream_U0_m_axi_gmem0_AWADDR),
    .m_axi_gmem0_AWID(Axi2AxiStream_U0_m_axi_gmem0_AWID),
    .m_axi_gmem0_AWLEN(Axi2AxiStream_U0_m_axi_gmem0_AWLEN),
    .m_axi_gmem0_AWSIZE(Axi2AxiStream_U0_m_axi_gmem0_AWSIZE),
    .m_axi_gmem0_AWBURST(Axi2AxiStream_U0_m_axi_gmem0_AWBURST),
    .m_axi_gmem0_AWLOCK(Axi2AxiStream_U0_m_axi_gmem0_AWLOCK),
    .m_axi_gmem0_AWCACHE(Axi2AxiStream_U0_m_axi_gmem0_AWCACHE),
    .m_axi_gmem0_AWPROT(Axi2AxiStream_U0_m_axi_gmem0_AWPROT),
    .m_axi_gmem0_AWQOS(Axi2AxiStream_U0_m_axi_gmem0_AWQOS),
    .m_axi_gmem0_AWREGION(Axi2AxiStream_U0_m_axi_gmem0_AWREGION),
    .m_axi_gmem0_AWUSER(Axi2AxiStream_U0_m_axi_gmem0_AWUSER),
    .m_axi_gmem0_WVALID(Axi2AxiStream_U0_m_axi_gmem0_WVALID),
    .m_axi_gmem0_WREADY(1'b0),
    .m_axi_gmem0_WDATA(Axi2AxiStream_U0_m_axi_gmem0_WDATA),
    .m_axi_gmem0_WSTRB(Axi2AxiStream_U0_m_axi_gmem0_WSTRB),
    .m_axi_gmem0_WLAST(Axi2AxiStream_U0_m_axi_gmem0_WLAST),
    .m_axi_gmem0_WID(Axi2AxiStream_U0_m_axi_gmem0_WID),
    .m_axi_gmem0_WUSER(Axi2AxiStream_U0_m_axi_gmem0_WUSER),
    .m_axi_gmem0_ARVALID(Axi2AxiStream_U0_m_axi_gmem0_ARVALID),
    .m_axi_gmem0_ARREADY(m_axi_gmem1_ARREADY),
    .m_axi_gmem0_ARADDR(Axi2AxiStream_U0_m_axi_gmem0_ARADDR),
    .m_axi_gmem0_ARID(Axi2AxiStream_U0_m_axi_gmem0_ARID),
    .m_axi_gmem0_ARLEN(Axi2AxiStream_U0_m_axi_gmem0_ARLEN),
    .m_axi_gmem0_ARSIZE(Axi2AxiStream_U0_m_axi_gmem0_ARSIZE),
    .m_axi_gmem0_ARBURST(Axi2AxiStream_U0_m_axi_gmem0_ARBURST),
    .m_axi_gmem0_ARLOCK(Axi2AxiStream_U0_m_axi_gmem0_ARLOCK),
    .m_axi_gmem0_ARCACHE(Axi2AxiStream_U0_m_axi_gmem0_ARCACHE),
    .m_axi_gmem0_ARPROT(Axi2AxiStream_U0_m_axi_gmem0_ARPROT),
    .m_axi_gmem0_ARQOS(Axi2AxiStream_U0_m_axi_gmem0_ARQOS),
    .m_axi_gmem0_ARREGION(Axi2AxiStream_U0_m_axi_gmem0_ARREGION),
    .m_axi_gmem0_ARUSER(Axi2AxiStream_U0_m_axi_gmem0_ARUSER),
    .m_axi_gmem0_RVALID(m_axi_gmem1_RVALID),
    .m_axi_gmem0_RREADY(Axi2AxiStream_U0_m_axi_gmem0_RREADY),
    .m_axi_gmem0_RDATA(m_axi_gmem1_RDATA),
    .m_axi_gmem0_RLAST(m_axi_gmem1_RLAST),
    .m_axi_gmem0_RID(m_axi_gmem1_RID),
    .m_axi_gmem0_RFIFONUM(m_axi_gmem1_RFIFONUM),
    .m_axi_gmem0_RUSER(m_axi_gmem1_RUSER),
    .m_axi_gmem0_RRESP(m_axi_gmem1_RRESP),
    .m_axi_gmem0_BVALID(1'b0),
    .m_axi_gmem0_BREADY(Axi2AxiStream_U0_m_axi_gmem0_BREADY),
    .m_axi_gmem0_BRESP(2'd0),
    .m_axi_gmem0_BID(1'd0),
    .m_axi_gmem0_BUSER(1'd0),
    .din(din),
    .ldata_din(Axi2AxiStream_U0_ldata_din),
    .ldata_num_data_valid(ldata_num_data_valid),
    .ldata_fifo_cap(ldata_fifo_cap),
    .ldata_full_n(ldata_full_n),
    .ldata_write(Axi2AxiStream_U0_ldata_write)
);

xf_cv_subtract_AxiStream2Mat AxiStream2Mat_U0(
    .ldata_dout(ldata_dout),
    .ldata_empty_n(ldata_empty_n),
    .ldata_read(AxiStream2Mat_U0_ldata_read),
    .imgInput1_data_din(AxiStream2Mat_U0_imgInput1_data_din),
    .imgInput1_data_full_n(imgInput2_data_full_n),
    .imgInput1_data_write(AxiStream2Mat_U0_imgInput1_data_write),
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(AxiStream2Mat_U0_ap_start),
    .ap_done(AxiStream2Mat_U0_ap_done),
    .ap_ready(AxiStream2Mat_U0_ap_ready),
    .ap_idle(AxiStream2Mat_U0_ap_idle),
    .ap_continue(AxiStream2Mat_U0_ap_continue)
);

xf_cv_subtract_fifo_w32_d2_S ldata_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2AxiStream_U0_ldata_din),
    .if_full_n(ldata_full_n),
    .if_write(Axi2AxiStream_U0_ldata_write),
    .if_dout(ldata_dout),
    .if_num_data_valid(ldata_num_data_valid),
    .if_fifo_cap(ldata_fifo_cap),
    .if_empty_n(ldata_empty_n),
    .if_read(AxiStream2Mat_U0_ldata_read)
);

xf_cv_subtract_start_for_AxiStream2Mat_U0 start_for_AxiStream2Mat_U0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_AxiStream2Mat_U0_din),
    .if_full_n(start_for_AxiStream2Mat_U0_full_n),
    .if_write(Axi2AxiStream_U0_start_write),
    .if_dout(start_for_AxiStream2Mat_U0_dout),
    .if_empty_n(start_for_AxiStream2Mat_U0_empty_n),
    .if_read(AxiStream2Mat_U0_ap_ready)
);

assign Axi2AxiStream_U0_ap_continue = 1'b1;

assign Axi2AxiStream_U0_ap_start = ap_start;

assign AxiStream2Mat_U0_ap_continue = ap_continue;

assign AxiStream2Mat_U0_ap_start = start_for_AxiStream2Mat_U0_empty_n;

assign ap_done = AxiStream2Mat_U0_ap_done;

assign ap_idle = (AxiStream2Mat_U0_ap_idle & Axi2AxiStream_U0_ap_idle);

assign ap_ready = Axi2AxiStream_U0_ap_ready;

assign imgInput2_data_din = AxiStream2Mat_U0_imgInput1_data_din;

assign imgInput2_data_write = AxiStream2Mat_U0_imgInput1_data_write;

assign m_axi_gmem1_ARADDR = Axi2AxiStream_U0_m_axi_gmem0_ARADDR;

assign m_axi_gmem1_ARBURST = Axi2AxiStream_U0_m_axi_gmem0_ARBURST;

assign m_axi_gmem1_ARCACHE = Axi2AxiStream_U0_m_axi_gmem0_ARCACHE;

assign m_axi_gmem1_ARID = Axi2AxiStream_U0_m_axi_gmem0_ARID;

assign m_axi_gmem1_ARLEN = Axi2AxiStream_U0_m_axi_gmem0_ARLEN;

assign m_axi_gmem1_ARLOCK = Axi2AxiStream_U0_m_axi_gmem0_ARLOCK;

assign m_axi_gmem1_ARPROT = Axi2AxiStream_U0_m_axi_gmem0_ARPROT;

assign m_axi_gmem1_ARQOS = Axi2AxiStream_U0_m_axi_gmem0_ARQOS;

assign m_axi_gmem1_ARREGION = Axi2AxiStream_U0_m_axi_gmem0_ARREGION;

assign m_axi_gmem1_ARSIZE = Axi2AxiStream_U0_m_axi_gmem0_ARSIZE;

assign m_axi_gmem1_ARUSER = Axi2AxiStream_U0_m_axi_gmem0_ARUSER;

assign m_axi_gmem1_ARVALID = Axi2AxiStream_U0_m_axi_gmem0_ARVALID;

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

assign m_axi_gmem1_RREADY = Axi2AxiStream_U0_m_axi_gmem0_RREADY;

assign m_axi_gmem1_WDATA = 32'd0;

assign m_axi_gmem1_WID = 1'd0;

assign m_axi_gmem1_WLAST = 1'b0;

assign m_axi_gmem1_WSTRB = 4'd0;

assign m_axi_gmem1_WUSER = 1'd0;

assign m_axi_gmem1_WVALID = 1'b0;

assign start_for_AxiStream2Mat_U0_din = 1'b1;

endmodule //xf_cv_subtract_Axi2Mat
