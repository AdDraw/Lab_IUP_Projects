library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Display is
    Port(  clk_i 		: in  	STD_LOGIC; --50MHz
           rst_i 		: in  	STD_LOGIC; --asynchronous GLOBAL
           digit_i 		: in 	STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o 	: out  	STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o 	: out  	STD_LOGIC_VECTOR (7 downto 0));
end  Display;

architecture Behavioral of Display is
	signal counter:  Integer range 0 to 3 := 0;
begin
	process (clk_i,rst_i,digit_i)
	begin
		if rst_i='1' then
			counter <= 0;
		elsif clk_i='1' and clk_i'event then
			counter <= (counter + 1) mod 4;
			CASE counter IS
			WHEN  0  	=> 
				led7_an_o 	<= "1110";
				led7_seg_o 	<= digit_i(7 downto 0);
			WHEN  1 	=>
				led7_an_o 	<= "1101";
				led7_seg_o 	<= digit_i(15 downto 8);
			WHEN  2  	=>  
				led7_an_o 	<= "1011";
				led7_seg_o 	<= digit_i(23 downto 16);
			WHEN  3  	=>  
				led7_an_o 	<= "0111";
				led7_seg_o 	<= digit_i(31 downto 24);
			WHEN OTHERS =>  
				led7_an_o 	<= "XXXX";
				led7_seg_o 	<= "XXXXXXXX";
			 END CASE;
		end if;
	end process;
end Behavioral;