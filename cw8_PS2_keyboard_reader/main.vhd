library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY main IS
    Port ( clk_i	 	: IN  	STD_LOGIC;
           rst_i 		: IN  	STD_LOGIC;
           led7_an_o 	: OUT  	STD_LOGIC_VECTOR (3 DOWNTO 0);
           led7_seg_o 	: OUT  	STD_LOGIC_VECTOR (7 DOWNTO 0);
           ps2_clk_i 	: IN  	STD_LOGIC;
           ps2_data_i 	: IN  	STD_LOGIC );
END main;

ARCHITECTURE Behavioral of main is
	
	--Constants
	CONSTANT D00 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000001"; 
	CONSTANT D01 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1001111"; 
	CONSTANT D02 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010"; 
	CONSTANT D03 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110"; 
	CONSTANT D04 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1001100"; 
	CONSTANT D05 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100"; 
	CONSTANT D06 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100000"; 
	CONSTANT D07 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001111"; 
	CONSTANT D08 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000"; 
	CONSTANT D09 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000100"; 
	CONSTANT D10 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001000"; 
	CONSTANT D11 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1100000"; 
	CONSTANT D12 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110001"; 
	CONSTANT D13 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000010"; 
	CONSTANT D14 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000"; 
	CONSTANT D15 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0111000"; 
	type table0 is Array (0 TO 9) of STD_LOGIC_VECTOR(6 DOWNTO 0);
	CONSTANT table1: table0:=(D00,D01,D02,D03,D04,D05,D06,D07,D08,D09);
	
	--Signals
	SIGNAL clock			: STD_LOGIC;
	SIGNAL clk_display		: STD_LOGIC;
	SIGNAL state			: INTEGER RANGE 0 TO 15:=0;
	SIGNAL counter			: INTEGER RANGE 0 TO 15;
	SIGNAL counter2			: INTEGER RANGE 0 TO 15;
	SIGNAL data				: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL numbers			: STD_LOGIC_VECTOR (31 DOWNTO 0) := "11111111111111111111111111111111";
	
	--Component definitons
	COMPONENT clkTest
		PORT( 	clk_i 		: IN  	STD_LOGIC;
				ps2_clk_i 	: IN 	STD_LOGIC;
				clk_o 		: OUT 	STD_LOGIC );
	END COMPONENT;
	COMPONENT display
		PORT( 	clk_i 		: IN  	STD_LOGIC;
				rst_i 		: IN  	STD_LOGIC;
				digit_i		: IN  	STD_LOGIC_VECTOR (31 DOWNTO 0);
				led7_an_o 	: OUT  	STD_LOGIC_VECTOR (3 DOWNTO 0);
				led7_seg_o 	: OUT  	STD_LOGIC_VECTOR (7 DOWNTO 0) );
	END COMPONENT;
	COMPONENT clkGen
		PORT(	clk_i		: IN  	STD_LOGIC;
				rst_i 		: IN  	STD_LOGIC;
				clk_o 		: OUT  	STD_LOGIC );
	END COMPONENT;
	
BEGIN
	uut0: clkTest PORT MAP(	clk_i 		=> clk_i,
							ps2_clk_i 	=> ps2_clk_i,
							clk_o 		=> clock );
							
	uut1: display PORT MAP( clk_i 		=> clk_display,
							rst_i 		=> rst_i,
							digit_i 	=> numbers,
							led7_an_o 	=> led7_an_o,
							led7_seg_o 	=> led7_seg_o );
							
	uut2: clkGen  PORT MAP( clk_i 		=> clk_i,
							rst_i 		=> rst_i,
							clk_o 		=> clk_display );
	PROCESS(rst_i,clock)
	BEGIN
		IF rst_i='1' THEN
			numbers(7 DOWNTO 1) <= "1111111";
		ELSIF rising_edge(clock) THEN
			IF counter2 = 15 THEN
				counter2 <= 0;
			ELSE
				counter2 <= counter2 + 1;
			END IF;
			IF state = 0 THEN
				IF ps2_data_i = '0' THEN
					state <= 1;
				END IF;
			ELSIF state = 1 THEN
				data(counter) <= ps2_data_i;
				IF counter = 7 THEN
					state 	<= 2;
					counter <= 0;
				ELSE
					counter <= counter + 1;
				END IF;
			ELSIF state = 2 THEN
				state <= 3;
			ELSIF state = 3 THEN
				case data is
					when "01000101" => numbers(7 DOWNTO 1) <= D00;
					when "00010110" => numbers(7 DOWNTO 1) <= D01;
					when "00011110" => numbers(7 DOWNTO 1) <= D02;
					when "00100110" => numbers(7 DOWNTO 1) <= D03;
					when "00100101" => numbers(7 DOWNTO 1) <= D04;
					when "00101110" => numbers(7 DOWNTO 1) <= D05;
					when "00110110" => numbers(7 DOWNTO 1) <= D06;
					when "00111101" => numbers(7 DOWNTO 1) <= D07;
					when "00111110" => numbers(7 DOWNTO 1) <= D08;
					when "01000110" => numbers(7 DOWNTO 1) <= D09;
					when "00011100" => numbers(7 DOWNTO 1) <= D10;
					when "00110010" => numbers(7 DOWNTO 1) <= D11;
					when "00100001" => numbers(7 DOWNTO 1) <= D12;
					when "00100011" => numbers(7 DOWNTO 1) <= D13;
					when "00100100" => numbers(7 DOWNTO 1) <= D14;
					when "00101011" => numbers(7 DOWNTO 1) <= D15;
					when others 	=> numbers(7 DOWNTO 1) <= "1010101";
				END case;
				state <= 0;
			END IF;
		END IF;
	END process;
END Behavioral;

