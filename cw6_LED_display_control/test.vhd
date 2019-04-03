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
			sw_i 	<= "01000101";
			btn_i 	<= "0001";
		wait for 20ns;	
			btn_i 	<= "0000";
		wait for 20ns;
			sw_i 	<= "10100100";
			btn_i 	<= "0010";
		wait for 20ns;	
			btn_i 	<= "0000";
		wait for 20ns;	
			sw_i 	<= "00000001";
			btn_i 	<= "0100";
		wait for 20ns;	
			btn_i 	<= "0000";
		wait for 20ns;	
			sw_i 	<= "00101001";
			btn_i 	<= "1000";
		wait for 20ns;	
			btn_i <= "0000";	
		wait for clk_i_period*10;
		wait;
   end process;
END;
