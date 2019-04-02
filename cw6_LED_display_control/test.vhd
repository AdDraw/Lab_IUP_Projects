--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:34:17 03/16/2013
-- Design Name:   
-- Module Name:   C:/Users/Adi/cw6/test.vhd
-- Project Name:  cw6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cw6
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk_i : IN  std_logic;
         btn_i : IN  std_logic_vector(3 downto 0);
         sw_i : IN  std_logic_vector(7 downto 0);
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal btn_i : std_logic_vector(3 downto 0) := (others => '0');
   signal sw_i : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk_i => clk_i,
          btn_i => btn_i,
          sw_i => sw_i,
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ns;	
		sw_i <= "01000101";
		btn_i <= "0001";
      wait for 20ns;	
		btn_i <= "0000";
      wait for 20ns;
		sw_i <= "10100100";
		btn_i <= "0010";
      wait for 20ns;	
		btn_i <= "0000";
      wait for 20ns;	
		sw_i <= "00000001";
		btn_i <= "0100";
      wait for 20ns;	
		btn_i <= "0000";
      wait for 20ns;	
		sw_i <= "00101001";
		btn_i <= "1000";
      wait for 20ns;	
		btn_i <= "0000";
		
      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
