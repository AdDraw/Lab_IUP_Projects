--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:01:40 03/21/2013
-- Design Name:   
-- Module Name:   C:/Users/Adi/cw6v2/cw6/test_clkgen.vhd
-- Project Name:  cw6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Clkgen
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
 
ENTITY test_clkgen IS
END test_clkgen;
 
ARCHITECTURE behavior OF test_clkgen IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Clkgen
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         clk_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';

 	--Outputs
   signal clk_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Clkgen PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
