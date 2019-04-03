library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
    Port ( start_stop_button_i : in  STD_LOGIC;
           clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
	--Hexadecimal Display Codes
	constant D00 : STD_LOGIC_VECTOR(6 downto 0) := "0000001"; 
	constant D01 : STD_LOGIC_VECTOR(6 downto 0) := "1001111"; 
	constant D02 : STD_LOGIC_VECTOR(6 downto 0) := "0010010"; 
	constant D03 : STD_LOGIC_VECTOR(6 downto 0) := "0000110"; 
	constant D04 : STD_LOGIC_VECTOR(6 downto 0) := "1001100"; 
	constant D05 : STD_LOGIC_VECTOR(6 downto 0) := "0100100"; 
	constant D06 : STD_LOGIC_VECTOR(6 downto 0) := "0100000"; 
	constant D07 : STD_LOGIC_VECTOR(6 downto 0) := "0001111"; 
	constant D08 : STD_LOGIC_VECTOR(6 downto 0) := "0000000"; 
	constant D09 : STD_LOGIC_VECTOR(6 downto 0) := "0000100"; 
	type 	 table0 is Array (0 to 9) of STD_LOGIC_VECTOR(6 downto 0);
	constant table1: table0:=(D00,D01,D02,D03,D04,D05,D06,D07,D08,D09);
	
	signal digit  	:  	STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001";
	signal clock  	:  	STD_LOGIC := '0';
	signal button 	:  	STD_LOGIC := '0';
	signal state	: 	Integer range 0 to 3 := 0;
	signal counter 	:  	Integer range 0 to 9 := 0;
	signal counter0	:  	Integer range 0 to 9 := 0;
	signal counter1	:  	Integer range 0 to 9 := 0;
	signal counter2	:  	Integer range 0 to 9 := 0;
	signal counter3	:  	Integer range 0 to 9 := 0;

	Component Clkgen 
		Port( 	clk_i 		: in  	STD_LOGIC;
				rst_i 		: in  	STD_LOGIC;
				clk_o 		: out  	STD_LOGIC);
	END Component;
	Component Display
		Port( 	clk_i		: in  	STD_LOGIC;
				rst_i 		: in  	STD_LOGIC;
				digit_i 	: in  	STD_LOGIC_VECTOR (31 downto 0);
				led7_an_o 	: out  	STD_LOGIC_VECTOR (3 downto 0);
				led7_seg_o 	: out  	STD_LOGIC_VECTOR (7 downto 0));
	END Component;
	
begin
	--PortMapping
	uut0: Clkgen PORT MAP(	clk_i 		=> clk_i,
							rst_i 		=> rst_i,
							clk_o 		=> clock);
							
	uut1: Display PORT MAP(	clk_i 		=> clock,
							rst_i 		=> rst_i,
							digit_i 	=> digit,
							led7_an_o 	=> led7_an_o,
							led7_seg_o 	=> led7_seg_o
	);
	
	--Sequential
	process ( clock, rst_i ) -- state: | 0=RDY | 1=COUNT | 2=STOP | 3=OVRFLW(STOP) |
	begin
		if rst_i = '1' then
			state 		<= 0;
			button 		<= '1';
			counter 	<= 0;
			counter0 	<= 0;
			counter1 	<= 0;
			counter2 	<= 0;
			counter3 	<= 0;
		elsif rising_edge( clock ) then
			if start_stop_button_i = '1' and button = '0' then
				case state is
					when 0 =>   	state 		<= 1;
					when 1 =>   	state 		<= 2;
					when others => 	state 		<= 0;
									counter 	<= 0;
									counter0 	<= 0;
									counter1 	<= 0;
									counter2 	<= 0;
									counter3 	<= 0;
				end case;
			end if;
			button <= start_stop_button_i;
			if state = 1 then
				if counter < 9 then
					counter <= counter + 1;
				else
					counter <= 0;
					if counter0 < 9 then
						counter0 <= counter0 + 1;
					else
						counter0 <= 0;
						if counter1 < 9 then
							counter1 <= counter1 + 1;
						else
							counter1 <= 0;
							if counter2 < 9 then
								counter2 <= counter2 + 1;
							else
								counter2 <=0;
								if counter3 < 5 then
									counter3 <= counter3 + 1;
								else
									state <= 3;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--Combinational 2nd
	digit(7 downto 0) 	<= table1(counter0) & '1' when state < 3 else "11111101";	
	digit(15 downto 8) 	<= table1(counter1) & '1' when state < 3 else "11111101";	
	digit(23 downto 16) <= table1(counter2) & '0' when state < 3 else "11111100";	
	digit(31 downto 24) <= table1(counter3) & '1' when state < 3 else "11111101";	
	
end Behavioral;

