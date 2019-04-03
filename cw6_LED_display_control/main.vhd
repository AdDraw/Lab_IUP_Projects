library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
Port ( 	clk_i 		: in  	STD_LOGIC;
		btn_i 		: in  	STD_LOGIC_VECTOR (3 downto 0);
        sw_i		: in  	STD_LOGIC_VECTOR (7 downto 0);
        led7_an_o 	: out 	STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o 	: out  	STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is

	signal Clock:  STD_LOGIC;
	signal Digit:  STD_LOGIC_VECTOR(31 downto 0) 	:= "00000001000000010000000100000001";
	signal Seg_o:  STD_LOGIC_VECTOR(6 downto 0) 	:= "0000001";
		
	--HEX DISPLAY CODES
	constant Reset 	: STD_LOGIC						:= '0';
	constant D00 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0000001"; 
	constant D01 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "1001111"; 
	constant D02 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0010010"; 
	constant D03 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0000110"; 
	constant D04 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "1001100"; 
	constant D05 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0100100"; 
	constant D06 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0100000"; 
	constant D07 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0001111"; 
	constant D08 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0000000"; 
	constant D09 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0000100"; 
	constant D10 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0001000"; 
	constant D11 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "1100000"; 
	constant D12 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0110001"; 
	constant D13 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "1000010"; 
	constant D14 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0110000"; 	
	constant D15 	: STD_LOGIC_VECTOR(6 downto 0) 	:= "0111000"; 
		
	--Components
	Component Clkgen
		Port( 	clk_i : in  STD_LOGIC;
				rst_i : in  STD_LOGIC;
				clk_o : out  STD_LOGIC);
	END Component;

	Component Display
		Port( 	clk_i : in  STD_LOGIC;
				rst_i : in  STD_LOGIC;
				digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
				led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
				led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
	END Component;

--Combinational/Sequential Logic
begin
--Combinational Logic
--Port Mapping
	uut0: Clkgen PORT MAP(  clk_i 		=> clk_i,
							rst_i 		=> Reset,
							clk_o 		=> Clock);
						
	uut1: Display PORT MAP( clk_i 		=> Clock,
							rst_i 		=> Reset,
							digit_i 	=> Digit,
							led7_an_o 	=> led7_an_o,
							led7_seg_o 	=> led7_seg_o);

	WITH sw_i(3 downto 0)  SELECT
		Seg_o <= D00 WHEN  "0000",
				 D01 WHEN  "0001",
				 D02 WHEN  "0010",
				 D03 WHEN  "0011",
				 D04 WHEN  "0100",
				 D05 WHEN  "0101",
				 D06 WHEN  "0110",
				 D07 WHEN  "0111",
				 D08 WHEN  "1000",
				 D09 WHEN  "1001",
				 D10 WHEN  "1010",
				 D11 WHEN  "1011",
				 D12 WHEN  "1100",
				 D13 WHEN  "1101",
				 D14 WHEN  "1110",
				 D15 WHEN  "1111",
				 "XXXXXXX" WHEN OTHERS;

--Sequential Logic
	process (clk_i,sw_i,btn_i)
	begin
		if rising_edge(clk_i) then
			Digit(0)  <= not sw_i(4);
			Digit(8)  <= not sw_i(5);
			Digit(16) <= not sw_i(6);
			Digit(24) <= not sw_i(7);
			
			if btn_i = "0001" then
				Digit(7 downto 1) <= Seg_o;
			end if;
			
			if btn_i = "0010" then
				Digit(15 downto 9) <= Seg_o;
			end if;
			
			if btn_i = "0100" then
				Digit(23 downto 17) <= Seg_o;
			end if;
			
			if btn_i = "1000" then
				Digit(31 downto 25) <= Seg_o;
			end if;
		end if;
	end process;
end Behavioral;

