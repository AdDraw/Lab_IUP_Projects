--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:25:43 04/02/2013
-- Design Name:   
-- Module Name:   C:/Users/Adi/cw8/test_clkTest.vhd
-- Project Name:  cw8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clkTest
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
 
ENTITY test_clkTest IS
END test_clkTest;
 
ARCHITECTURE behavior OF test_clkTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clkTest
    PORT(
         clk_i : IN  std_logic;
         ps2_clk_i : IN  std_logic;
         clk_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal ps2_clk_i : std_logic := '0';

 	--Outputs
   signal clk_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 5ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clkTest PORT MAP (
          clk_i => clk_i,
          ps2_clk_i => ps2_clk_i,
          clk_o => clk_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
	
   ps2_clk_i_process :process
   begin
		ps2_clk_i <= '0';
		wait for clk_i_period*10/2;
		ps2_clk_i <= '1';
		wait for clk_i_period*10/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.


      -- insert stimulus here 

      wait;
   end process;

END;
