--TESTBENCH
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cw5
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         led_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';

 	--Outputs
   signal led_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 20ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cw5 PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          led_o => led_o
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
      wait for 100ps;	
		rst_i <= '1';
		wait for 40ps;	
		rst_i <= '0';
      wait;
   end process;

END;
