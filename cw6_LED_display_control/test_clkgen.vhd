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
      wait;
   end process;

END;
