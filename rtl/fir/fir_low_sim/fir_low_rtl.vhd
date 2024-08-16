----------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 13.0sp1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2013 Altera Corporation.  All rights reserved.    
-- Your use of  Altera  Corporation's design tools,  logic functions and other 
-- software and tools,  and its AMPP  partner logic functions, and  any output 
-- files  any of the  foregoing  device programming or simulation files),  and 
-- any associated  documentation or information are expressly subject  to  the 
-- terms and conditions  of the Altera Program License Subscription Agreement, 
-- Altera  MegaCore  Function  License  Agreement, or other applicable license 
-- agreement,  including,  without limitation,  that your use  is for the sole 
-- purpose of  programming  logic  devices  manufactured by Altera and sold by 
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable 
-- agreement for further details.
----------------------------------------------------------------------------- 

-- VHDL created from fir_low_rtl
-- VHDL created on Sat Nov 13 15:03:45 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

-- Text written from d:/SJ/nightly/13.0sp1/232/w32/p4/ip/aion/src/mip_common/hw_model.cpp:1303
entity fir_low_rtl is
    port (
        xIn_v : in std_logic_vector(0 downto 0);
        xIn_c : in std_logic_vector(7 downto 0);
        xIn_0 : in std_logic_vector(7 downto 0);
        xOut_v : out std_logic_vector(0 downto 0);
        xOut_c : out std_logic_vector(7 downto 0);
        xOut_0 : out std_logic_vector(23 downto 0);
        clk : in std_logic;
        areset : in std_logic
        );
end;

architecture normal of fir_low_rtl is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name NOT_GATE_PUSH_BACK OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410";

    signal GND_q : std_logic_vector (0 downto 0);
    signal VCC_q : std_logic_vector (0 downto 0);
    signal d_xIn_0_13_q : std_logic_vector (7 downto 0);
    signal d_in0_m0_wi0_wo0_assign_sel_q_13_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_run_count : std_logic_vector(1 downto 0);
    signal u0_m0_wo0_run_pre_ena_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_run_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_run_out : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_run_enable_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_run_ctrl : std_logic_vector(2 downto 0);
    signal u0_m0_wo0_memread_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_compute_q : std_logic_vector (0 downto 0);
    signal d_u0_m0_wo0_compute_q_14_q : std_logic_vector (0 downto 0);
    signal d_u0_m0_wo0_compute_q_15_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_q : std_logic_vector(4 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_i : unsigned(3 downto 0);
    signal u0_m0_wo0_wi0_ra0_count0_sc : signed(4 downto 0);
    signal u0_m0_wo0_wi0_ra0_count1_q : std_logic_vector(4 downto 0);
    signal u0_m0_wo0_wi0_ra0_count1_i : unsigned(3 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_a : std_logic_vector(5 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_b : std_logic_vector(5 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_o : std_logic_vector (5 downto 0);
    signal u0_m0_wo0_wi0_ra0_add_0_0_q : std_logic_vector (5 downto 0);
    signal u0_m0_wo0_wi0_wa0_q : std_logic_vector(3 downto 0);
    signal u0_m0_wo0_wi0_wa0_i : unsigned(3 downto 0);
    signal u0_m0_wo0_wi0_delayr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_delayr0_ia : std_logic_vector (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_aa : std_logic_vector (3 downto 0);
    signal u0_m0_wo0_wi0_delayr0_ab : std_logic_vector (3 downto 0);
    signal u0_m0_wo0_wi0_delayr0_iq : std_logic_vector (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_q : std_logic_vector (7 downto 0);
    signal u0_m0_wo0_ca0_q : std_logic_vector(3 downto 0);
    signal u0_m0_wo0_ca0_i : unsigned(3 downto 0);
    signal u0_m0_wo0_cm0_q : std_logic_vector(11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_a : std_logic_vector (11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_b : std_logic_vector (7 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_s1 : std_logic_vector (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_q : std_logic_vector (19 downto 0);
    signal u0_m0_wo0_aseq_q : std_logic_vector(0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : std_logic_vector(23 downto 0);
    signal u0_m0_wo0_accum_b : std_logic_vector(23 downto 0);
    signal u0_m0_wo0_accum_i : std_logic_vector (23 downto 0);
    signal u0_m0_wo0_accum_o : std_logic_vector (23 downto 0);
    signal u0_m0_wo0_accum_q : std_logic_vector (23 downto 0);
    signal u0_m0_wo0_oseq_q : std_logic_vector(0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : std_logic_vector (0 downto 0);
    signal u0_m0_wo0_oseq_gated_a : std_logic_vector(0 downto 0);
    signal u0_m0_wo0_oseq_gated_b : std_logic_vector(0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : std_logic_vector(0 downto 0);
    signal u0_m0_wo0_wi0_ra0_resize_in : std_logic_vector (3 downto 0);
    signal u0_m0_wo0_wi0_ra0_resize_b : std_logic_vector (3 downto 0);
begin


	--VCC(CONSTANT,1)@0
    VCC_q <= "1";

	--xIn(PORTIN,2)@10

	--u0_m0_wo0_run(ENABLEGENERATOR,5)@10
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enable_q;
    u0_m0_wo0_run: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : signed(4 downto 0);
        variable u0_m0_wo0_run_inc : signed(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(14,5);
            u0_m0_wo0_run_enable_q <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (OTHERS => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(4) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-15);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enable_q <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(4 DOWNTO 4));
            ELSE
                u0_m0_wo0_run_enable_q <= "0";
            END IF;
            CASE u0_m0_wo0_run_ctrl is
                WHEN "000" | "001" =>
                    u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" =>
                    u0_m0_wo0_run_inc := "11";
                WHEN "100" =>
                    u0_m0_wo0_run_inc := "00";
                WHEN "101" =>
                    u0_m0_wo0_run_inc := "01";
                WHEN "110" =>
                    u0_m0_wo0_run_inc := "11";
                WHEN "111" =>
                    u0_m0_wo0_run_inc := "00";
                WHEN OTHERS =>
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_pre_ena_q <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_pre_ena_q AND VCC_q;

	--u0_m0_wo0_memread(DELAY,6)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

	--u0_m0_wo0_compute(DELAY,7)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

	--d_u0_m0_wo0_compute_q_14(DELAY,28)@12
    d_u0_m0_wo0_compute_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_14_q, clk => clk, aclr => areset );

	--u0_m0_wo0_aseq(SEQUENCE,18)@14
    u0_m0_wo0_aseq: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : signed (6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "0000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_14_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "0000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 15;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= std_logic_vector(u0_m0_wo0_aseq_c(6 DOWNTO 6));
            END IF;
        END IF;
    END PROCESS;


	--d_u0_m0_wo0_compute_q_15(DELAY,29)@14
    d_u0_m0_wo0_compute_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_14_q, xout => d_u0_m0_wo0_compute_q_15_q, clk => clk, aclr => areset );

	--d_xIn_0_13(DELAY,26)@10
    d_xIn_0_13 : dspba_delay
    GENERIC MAP ( width => 8, depth => 3 )
    PORT MAP ( xin => xIn_0, xout => d_xIn_0_13_q, clk => clk, aclr => areset );

	--u0_m0_wo0_wi0_wa0(COUNTER,12)@13
    -- every=1, low=0, high=15, step=1, init=15
    u0_m0_wo0_wi0_wa0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_wa0_i <= TO_UNSIGNED(15,4);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_sel_q_13_q = "1") THEN
                    u0_m0_wo0_wi0_wa0_i <= u0_m0_wo0_wi0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_wa0_q <= STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_wa0_i,4));


	--d_in0_m0_wi0_wo0_assign_sel_q_13(DELAY,27)@10
    d_in0_m0_wi0_wo0_assign_sel_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_sel_q_13_q, clk => clk, aclr => areset );

	--u0_m0_wo0_wi0_ra0_count1(COUNTER,9)@12
    -- every=1, low=0, high=15, step=1, init=0
    u0_m0_wo0_wi0_ra0_count1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_count1_i <= TO_UNSIGNED(0,4);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                    u0_m0_wo0_wi0_ra0_count1_i <= u0_m0_wo0_wi0_ra0_count1_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_count1_q <= STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra0_count1_i,5));


	--u0_m0_wo0_wi0_ra0_count0(COUNTER,8)@12
    -- every=16, low=0, high=15, step=1, init=0
    u0_m0_wo0_wi0_ra0_count0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_count0_i <= TO_UNSIGNED(0,4);
            u0_m0_wo0_wi0_ra0_count0_sc <= TO_SIGNED(14,5);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_ra0_count0_sc(4) = '1') THEN
                    u0_m0_wo0_wi0_ra0_count0_sc <= u0_m0_wo0_wi0_ra0_count0_sc - (-15);
                ELSE
                    u0_m0_wo0_wi0_ra0_count0_sc <= u0_m0_wo0_wi0_ra0_count0_sc + (-1);
                END IF;
                IF (u0_m0_wo0_wi0_ra0_count0_sc(4) = '1') THEN
                    u0_m0_wo0_wi0_ra0_count0_i <= u0_m0_wo0_wi0_ra0_count0_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_count0_q <= STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra0_count0_i,5));


	--u0_m0_wo0_wi0_ra0_add_0_0(ADD,10)@12
    u0_m0_wo0_wi0_ra0_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra0_count0_q);
    u0_m0_wo0_wi0_ra0_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra0_count1_q);
    u0_m0_wo0_wi0_ra0_add_0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra0_add_0_0_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_ra0_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_ra0_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_ra0_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra0_add_0_0_q <= u0_m0_wo0_wi0_ra0_add_0_0_o(5 downto 0);


	--u0_m0_wo0_wi0_ra0_resize(BITSELECT,11)@13
    u0_m0_wo0_wi0_ra0_resize_in <= u0_m0_wo0_wi0_ra0_add_0_0_q(3 downto 0);
    u0_m0_wo0_wi0_ra0_resize_b <= u0_m0_wo0_wi0_ra0_resize_in(3 downto 0);

	--u0_m0_wo0_wi0_delayr0(DUALMEM,13)@13
    u0_m0_wo0_wi0_delayr0_ia <= d_xIn_0_13_q;
    u0_m0_wo0_wi0_delayr0_aa <= u0_m0_wo0_wi0_wa0_q;
    u0_m0_wo0_wi0_delayr0_ab <= u0_m0_wo0_wi0_ra0_resize_b;
    u0_m0_wo0_wi0_delayr0_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 8,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone IV E"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => d_in0_m0_wi0_wo0_assign_sel_q_13_q(0),
        aclr0 => u0_m0_wo0_wi0_delayr0_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_delayr0_ab,
        -- data_b => (others => '0'),
        q_b => u0_m0_wo0_wi0_delayr0_iq,
        address_a => u0_m0_wo0_wi0_delayr0_aa,
        data_a => u0_m0_wo0_wi0_delayr0_ia
    );
    u0_m0_wo0_wi0_delayr0_reset0 <= areset;
        u0_m0_wo0_wi0_delayr0_q <= u0_m0_wo0_wi0_delayr0_iq(7 downto 0);

	--u0_m0_wo0_ca0(COUNTER,15)@12
    -- every=1, low=0, high=15, step=1, init=0
    u0_m0_wo0_ca0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca0_i <= TO_UNSIGNED(0,4);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca0_q <= STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca0_i,4));


	--u0_m0_wo0_cm0(LOOKUP,16)@12
    u0_m0_wo0_cm0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cm0_q <= "111111111100";
        ELSIF rising_edge(clk) THEN            CASE (u0_m0_wo0_ca0_q) IS
                WHEN "0000" =>  u0_m0_wo0_cm0_q <= "111111111100";
                WHEN "0001" =>  u0_m0_wo0_cm0_q <= "111111101000";
                WHEN "0010" =>  u0_m0_wo0_cm0_q <= "000000011000";
                WHEN "0011" =>  u0_m0_wo0_cm0_q <= "000001101110";
                WHEN "0100" =>  u0_m0_wo0_cm0_q <= "111110000011";
                WHEN "0101" =>  u0_m0_wo0_cm0_q <= "111010011110";
                WHEN "0110" =>  u0_m0_wo0_cm0_q <= "001000100010";
                WHEN "0111" =>  u0_m0_wo0_cm0_q <= "011111111111";
                WHEN "1000" =>  u0_m0_wo0_cm0_q <= "011111111111";
                WHEN "1001" =>  u0_m0_wo0_cm0_q <= "001000100010";
                WHEN "1010" =>  u0_m0_wo0_cm0_q <= "111010011110";
                WHEN "1011" =>  u0_m0_wo0_cm0_q <= "111110000011";
                WHEN "1100" =>  u0_m0_wo0_cm0_q <= "000001101110";
                WHEN "1101" =>  u0_m0_wo0_cm0_q <= "000000011000";
                WHEN "1110" =>  u0_m0_wo0_cm0_q <= "111111101000";
                WHEN "1111" =>  u0_m0_wo0_cm0_q <= "111111111100";
                WHEN OTHERS => -- unreachable
                    u0_m0_wo0_cm0_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;


	--u0_m0_wo0_mtree_mult1_0(MULT,17)@13
    u0_m0_wo0_mtree_mult1_0_a <= u0_m0_wo0_cm0_q;
    u0_m0_wo0_mtree_mult1_0_b <= u0_m0_wo0_wi0_delayr0_q;
    u0_m0_wo0_mtree_mult1_0_reset <= areset;

    u0_m0_wo0_mtree_mult1_0_component : lpm_mult
    GENERIC MAP (
    lpm_widtha => 12,
    lpm_widthb => 8,
    lpm_widthp => 20,
    lpm_widths => 1,
    lpm_type => "LPM_MULT",
    lpm_representation => "SIGNED",
    lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES,MAXIMIZE_SPEED=5",
    lpm_pipeline => 2
    )
    PORT MAP (
    dataa => u0_m0_wo0_mtree_mult1_0_a,
    datab => u0_m0_wo0_mtree_mult1_0_b,
    clken => VCC_q(0),
    aclr => u0_m0_wo0_mtree_mult1_0_reset,
    clock => clk,
    result => u0_m0_wo0_mtree_mult1_0_s1
    );
    u0_m0_wo0_mtree_mult1_0_q <= u0_m0_wo0_mtree_mult1_0_s1;

	--u0_m0_wo0_accum(ADD,19)@15
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR((23 downto 20 => u0_m0_wo0_mtree_mult1_0_q(19)) & u0_m0_wo0_mtree_mult1_0_q);
    u0_m0_wo0_accum_b <= u0_m0_wo0_accum_q;
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_15_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(23 downto 0);


	--GND(CONSTANT,0)@0
    GND_q <= "0";

	--u0_m0_wo0_oseq(SEQUENCE,20)@14
    u0_m0_wo0_oseq: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : signed (6 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "0001111";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_14_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "0000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 15;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= std_logic_vector(u0_m0_wo0_oseq_c(6 DOWNTO 6));
            END IF;
        END IF;
    END PROCESS;


	--u0_m0_wo0_oseq_gated(LOGICAL,21)@15
    u0_m0_wo0_oseq_gated_a <= u0_m0_wo0_oseq_q;
    u0_m0_wo0_oseq_gated_b <= d_u0_m0_wo0_compute_q_15_q;
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_gated_a and u0_m0_wo0_oseq_gated_b;

	--u0_m0_wo0_oseq_gated_reg(REG,22)@15
    u0_m0_wo0_oseq_gated_reg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF rising_edge(clk) THEN
            u0_m0_wo0_oseq_gated_reg_q <= u0_m0_wo0_oseq_gated_q;
        END IF;
    END PROCESS;


	--xOut(PORTOUT,25)@16
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;


end normal;
