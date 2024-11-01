-- ==============================================================
-- Generated by Vitis HLS v2024.1
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    imgInput1_data_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    imgInput1_data_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    imgInput1_data_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    imgInput1_data_empty_n : IN STD_LOGIC;
    imgInput1_data_read : OUT STD_LOGIC;
    imgInput2_data_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    imgInput2_data_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    imgInput2_data_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    imgInput2_data_empty_n : IN STD_LOGIC;
    imgInput2_data_read : OUT STD_LOGIC;
    imgOutput_data_din : OUT STD_LOGIC_VECTOR (23 downto 0);
    imgOutput_data_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    imgOutput_data_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    imgOutput_data_full_n : IN STD_LOGIC;
    imgOutput_data_write : OUT STD_LOGIC );
end;


architecture behav of xf_cv_subtract_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv11_0 : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv11_438 : STD_LOGIC_VECTOR (10 downto 0) := "10000111000";
    constant ap_const_lv11_1 : STD_LOGIC_VECTOR (10 downto 0) := "00000000001";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_17 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010111";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal icmp_ln827_fu_85_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal imgInput1_data_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal imgInput2_data_blk_n : STD_LOGIC;
    signal imgOutput_data_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal select_ln851_fu_136_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln851_reg_271 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln851_1_fu_190_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln851_1_reg_276 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln851_2_fu_244_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln851_2_reg_281 : STD_LOGIC_VECTOR (7 downto 0);
    signal j_fu_54 : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
    signal j_2_fu_91_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal ap_sig_allocacmp_j_1 : STD_LOGIC_VECTOR (10 downto 0);
    signal imgInput1_data_read_local : STD_LOGIC;
    signal imgInput2_data_read_local : STD_LOGIC;
    signal val_dst_fu_252_p4 : STD_LOGIC_VECTOR (23 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal imgOutput_data_write_local : STD_LOGIC;
    signal trunc_ln842_fu_102_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal trunc_ln844_fu_106_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln74_fu_110_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln74_1_fu_114_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal result_temp_fu_118_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal tmp_fu_124_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln851_fu_132_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_s_fu_144_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_1_fu_154_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln74_2_fu_164_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln74_3_fu_168_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal result_temp_1_fu_172_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal tmp_2_fu_178_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln851_1_fu_186_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_3_fu_198_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_4_fu_208_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln74_4_fu_218_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln74_5_fu_222_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal result_temp_2_fu_226_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal tmp_5_fu_232_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln851_2_fu_240_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter1_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ready_sig : STD_LOGIC;
    signal ap_done_sig : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component xf_cv_subtract_flow_control_loop_pipe_sequential_init IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC );
    end component;



begin
    flow_control_loop_pipe_sequential_init_U : component xf_cv_subtract_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready_sig,
        ap_done => ap_done_sig,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage0,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage0)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start_int;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    j_fu_54_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln827_fu_85_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    j_fu_54 <= j_2_fu_91_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    j_fu_54 <= ap_const_lv11_0;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
                select_ln851_1_reg_276 <= select_ln851_1_fu_190_p3;
                select_ln851_2_reg_281 <= select_ln851_2_fu_244_p3;
                select_ln851_reg_271 <= select_ln851_fu_136_p3;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_block_state2_pp0_stage0_iter1, ap_block_state3_pp0_stage0_iter2)
    begin
                ap_block_pp0_stage0_01001 <= (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state3_pp0_stage0_iter2)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state2_pp0_stage0_iter1)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_block_state2_pp0_stage0_iter1, ap_block_state3_pp0_stage0_iter2)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state3_pp0_stage0_iter2)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state2_pp0_stage0_iter1)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_block_state2_pp0_stage0_iter1, ap_block_state3_pp0_stage0_iter2)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state3_pp0_stage0_iter2)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_1 = ap_block_state2_pp0_stage0_iter1)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(imgInput1_data_empty_n, imgInput2_data_empty_n)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((imgInput2_data_empty_n = ap_const_logic_0) or (imgInput1_data_empty_n = ap_const_logic_0));
    end process;


    ap_block_state3_pp0_stage0_iter2_assign_proc : process(imgOutput_data_full_n)
    begin
                ap_block_state3_pp0_stage0_iter2 <= (imgOutput_data_full_n = ap_const_logic_0);
    end process;


    ap_condition_exit_pp0_iter0_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, icmp_ln827_fu_85_p2)
    begin
        if (((icmp_ln827_fu_85_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_done <= ap_done_sig;

    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_subdone, ap_done_reg, ap_loop_exit_ready_pp0_iter1_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start_int;

    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_idle_pp0 = ap_const_logic_1) and (ap_start_int = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage0;
    ap_ready <= ap_ready_sig;

    ap_ready_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_j_1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, j_fu_54, ap_loop_init)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_j_1 <= ap_const_lv11_0;
        else 
            ap_sig_allocacmp_j_1 <= j_fu_54;
        end if; 
    end process;

    icmp_ln827_fu_85_p2 <= "1" when (ap_sig_allocacmp_j_1 = ap_const_lv11_438) else "0";

    imgInput1_data_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, imgInput1_data_empty_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            imgInput1_data_blk_n <= imgInput1_data_empty_n;
        else 
            imgInput1_data_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    imgInput1_data_read <= imgInput1_data_read_local;

    imgInput1_data_read_local_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            imgInput1_data_read_local <= ap_const_logic_1;
        else 
            imgInput1_data_read_local <= ap_const_logic_0;
        end if; 
    end process;


    imgInput2_data_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, imgInput2_data_empty_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            imgInput2_data_blk_n <= imgInput2_data_empty_n;
        else 
            imgInput2_data_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    imgInput2_data_read <= imgInput2_data_read_local;

    imgInput2_data_read_local_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            imgInput2_data_read_local <= ap_const_logic_1;
        else 
            imgInput2_data_read_local <= ap_const_logic_0;
        end if; 
    end process;


    imgOutput_data_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, imgOutput_data_full_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            imgOutput_data_blk_n <= imgOutput_data_full_n;
        else 
            imgOutput_data_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    imgOutput_data_din <= val_dst_fu_252_p4;
    imgOutput_data_write <= imgOutput_data_write_local;

    imgOutput_data_write_local_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            imgOutput_data_write_local <= ap_const_logic_1;
        else 
            imgOutput_data_write_local <= ap_const_logic_0;
        end if; 
    end process;

    j_2_fu_91_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_j_1) + unsigned(ap_const_lv11_1));
    result_temp_1_fu_172_p2 <= std_logic_vector(unsigned(zext_ln74_2_fu_164_p1) - unsigned(zext_ln74_3_fu_168_p1));
    result_temp_2_fu_226_p2 <= std_logic_vector(unsigned(zext_ln74_4_fu_218_p1) - unsigned(zext_ln74_5_fu_222_p1));
    result_temp_fu_118_p2 <= std_logic_vector(unsigned(zext_ln74_fu_110_p1) - unsigned(zext_ln74_1_fu_114_p1));
    select_ln851_1_fu_190_p3 <= 
        ap_const_lv8_0 when (tmp_2_fu_178_p3(0) = '1') else 
        trunc_ln851_1_fu_186_p1;
    select_ln851_2_fu_244_p3 <= 
        ap_const_lv8_0 when (tmp_5_fu_232_p3(0) = '1') else 
        trunc_ln851_2_fu_240_p1;
    select_ln851_fu_136_p3 <= 
        ap_const_lv8_0 when (tmp_fu_124_p3(0) = '1') else 
        trunc_ln851_fu_132_p1;
    tmp_1_fu_154_p4 <= imgInput2_data_dout(15 downto 8);
    tmp_2_fu_178_p3 <= result_temp_1_fu_172_p2(8 downto 8);
    tmp_3_fu_198_p4 <= imgInput1_data_dout(23 downto 16);
    tmp_4_fu_208_p4 <= imgInput2_data_dout(23 downto 16);
    tmp_5_fu_232_p3 <= result_temp_2_fu_226_p2(8 downto 8);
    tmp_fu_124_p3 <= result_temp_fu_118_p2(8 downto 8);
    tmp_s_fu_144_p4 <= imgInput1_data_dout(15 downto 8);
    trunc_ln842_fu_102_p1 <= imgInput1_data_dout(8 - 1 downto 0);
    trunc_ln844_fu_106_p1 <= imgInput2_data_dout(8 - 1 downto 0);
    trunc_ln851_1_fu_186_p1 <= result_temp_1_fu_172_p2(8 - 1 downto 0);
    trunc_ln851_2_fu_240_p1 <= result_temp_2_fu_226_p2(8 - 1 downto 0);
    trunc_ln851_fu_132_p1 <= result_temp_fu_118_p2(8 - 1 downto 0);
    val_dst_fu_252_p4 <= ((select_ln851_2_reg_281 & select_ln851_1_reg_276) & select_ln851_reg_271);
    zext_ln74_1_fu_114_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln844_fu_106_p1),9));
    zext_ln74_2_fu_164_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_s_fu_144_p4),9));
    zext_ln74_3_fu_168_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_1_fu_154_p4),9));
    zext_ln74_4_fu_218_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_3_fu_198_p4),9));
    zext_ln74_5_fu_222_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_4_fu_208_p4),9));
    zext_ln74_fu_110_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln842_fu_102_p1),9));
end behav;
