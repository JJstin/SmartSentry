-- ==============================================================
-- Generated by Vitis HLS v2024.1
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xf_cv_subtract_Mat2AxiStream is
port (
    imgOutput_data_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    imgOutput_data_empty_n : IN STD_LOGIC;
    imgOutput_data_read : OUT STD_LOGIC;
    ldata_din : OUT STD_LOGIC_VECTOR (31 downto 0);
    ldata_full_n : IN STD_LOGIC;
    ldata_write : OUT STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC );
end;


architecture behav of xf_cv_subtract_Mat2AxiStream is 
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';

attribute shreg_extract : string;
    signal MatStream2AxiStream_2_U0_ap_start : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_ap_done : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_ap_continue : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_ap_idle : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_ap_ready : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_imgOutput_data_read : STD_LOGIC;
    signal MatStream2AxiStream_2_U0_ldata_din : STD_LOGIC_VECTOR (31 downto 0);
    signal MatStream2AxiStream_2_U0_ldata_write : STD_LOGIC;

    component xf_cv_subtract_MatStream2AxiStream_2_s IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        imgOutput_data_dout : IN STD_LOGIC_VECTOR (23 downto 0);
        imgOutput_data_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
        imgOutput_data_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
        imgOutput_data_empty_n : IN STD_LOGIC;
        imgOutput_data_read : OUT STD_LOGIC;
        ldata_din : OUT STD_LOGIC_VECTOR (31 downto 0);
        ldata_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
        ldata_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
        ldata_full_n : IN STD_LOGIC;
        ldata_write : OUT STD_LOGIC );
    end component;



begin
    MatStream2AxiStream_2_U0 : component xf_cv_subtract_MatStream2AxiStream_2_s
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => MatStream2AxiStream_2_U0_ap_start,
        ap_done => MatStream2AxiStream_2_U0_ap_done,
        ap_continue => MatStream2AxiStream_2_U0_ap_continue,
        ap_idle => MatStream2AxiStream_2_U0_ap_idle,
        ap_ready => MatStream2AxiStream_2_U0_ap_ready,
        imgOutput_data_dout => imgOutput_data_dout,
        imgOutput_data_num_data_valid => ap_const_lv3_0,
        imgOutput_data_fifo_cap => ap_const_lv3_0,
        imgOutput_data_empty_n => imgOutput_data_empty_n,
        imgOutput_data_read => MatStream2AxiStream_2_U0_imgOutput_data_read,
        ldata_din => MatStream2AxiStream_2_U0_ldata_din,
        ldata_num_data_valid => ap_const_lv3_0,
        ldata_fifo_cap => ap_const_lv3_0,
        ldata_full_n => ldata_full_n,
        ldata_write => MatStream2AxiStream_2_U0_ldata_write);




    MatStream2AxiStream_2_U0_ap_continue <= ap_continue;
    MatStream2AxiStream_2_U0_ap_start <= ap_start;
    ap_done <= MatStream2AxiStream_2_U0_ap_done;
    ap_idle <= MatStream2AxiStream_2_U0_ap_idle;
    ap_ready <= MatStream2AxiStream_2_U0_ap_ready;
    imgOutput_data_read <= MatStream2AxiStream_2_U0_imgOutput_data_read;
    ldata_din <= MatStream2AxiStream_2_U0_ldata_din;
    ldata_write <= MatStream2AxiStream_2_U0_ldata_write;
end behav;