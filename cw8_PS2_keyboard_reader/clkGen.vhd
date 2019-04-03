library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clkgen is
    Port( 	clk_i : in  	STD_LOGIC;
			rst_i : in  	STD_LOGIC;
			clk_o : out 	STD_LOGIC);
end Clkgen;

architecture Behavioral of Clkgen is
	constant N : Integer := 50000;
	signal counter:  Integer range 0 to N/2:=0;
	signal clock: std_logic:='0';
begin
	process (clk_i,rst_i)
	begin
		if rst_i='1' then
			counter <= 0;
			clock <= '0'; 
		elsif clk_i='1' and clk_i'event then
			if counter = N/2 then
				clock <= not clock;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	clk_o <= clock;
end Behavioral;

