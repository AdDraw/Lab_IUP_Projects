library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cw5 is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           led_o : out  STD_LOGIC);
end cw5;

architecture Behavioral of cw5 is

	constant N 		: Integer 	:= 9;
	signal counter	: Integer range 0 to N-1:=0; 
	signal counter2	: Integer range 0 to N/2:=0;
	signal clock	: std_logic	:='0';
	
begin

	process (clk_i,rst_i)
	begin
	if (N mod 2 = 1) then
		  if rst_i = '1' then
			  counter 	<= 0;
			  clock 	<= '0'; 
		  elsif clk_i = '1' and clk_i'event then
				counter		<= counter + 1;
				counter2 	<= counter2 + 1;
				if (counter = N-1 or counter2 = N/2) then
					clock 	 <= not clock;
					counter2 <= 0;
				end if;
				if counter = N-1 then
					counter <= 0;
				end if;
		  end if;
	else
		if rst_i='1' then
			counter2 <= 0;
			clock <= '0'; 
		elsif clk_i='1' and clk_i'event then
			counter2 <= counter2 + 1;
			if counter2 = N/2-1  then
				clock <= not clock;
				counter2 <= 0;
			end if;
		end if;
	end if;
	end process;
	led_o <= clock;
end Behavioral;

