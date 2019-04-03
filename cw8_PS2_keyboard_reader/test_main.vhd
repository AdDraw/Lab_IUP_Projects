LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY test_main IS
END test_main;
 
ARCHITECTURE behavior OF test_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0);
         ps2_clk_i : IN  std_logic;
         ps2_data_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal ps2_clk_i : std_logic := '0';
   signal ps2_data_i : std_logic := '0';

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 5ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o,
          ps2_clk_i => ps2_clk_i,
          ps2_data_i => ps2_data_i
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
		ps2_data_i <= '1';
		wait for clk_i_period*20*1.8;
		ps2_data_i <= '0';
		wait for clk_i_period*10*1;
		ps2_data_i <= '1';
		wait for clk_i_period*10*1;
		ps2_data_i <= '0';
		wait for clk_i_period*10*1;
		ps2_data_i <= '1';
		wait for clk_i_period*10*1;
		ps2_data_i <= '0';
		wait for clk_i_period*10*3;
		ps2_data_i <= '1';
		wait for clk_i_period*10*1;
		ps2_data_i <= '0';
		wait for clk_i_period*10*1;
		ps2_data_i <= '1';
		wait for 100ms;	
		wait for clk_i_period*10;
		wait;
   end process;

END;
