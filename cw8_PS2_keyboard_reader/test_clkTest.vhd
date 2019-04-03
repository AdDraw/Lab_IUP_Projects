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
 
END;
