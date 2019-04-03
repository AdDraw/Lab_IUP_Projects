library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY main IS
    Port(	clk_i 	: in  	STD_LOGIC;
			rst_i 	: in  	STD_LOGIC;
			TXD_o 	: out  	STD_LOGIC;
			RXD_i 	: in  	STD_LOGIC;
			sw_i 	: in  	STD_LOGIC;
			led_o 	: out  	STD_LOGIC_VECTOR (7 DOWNTO 0) );
END main;

ARCHITECTURE Behavioral of main IS
	CONSTANT N: INTEGER	:= 5208;
	
	SIGNAL A			: STD_LOGIC						:= '0';
	SIGNAL B			: STD_LOGIC						:= '0';
	SIGNAL C			: STD_LOGIC						:= '0';
	SIGNAL state		: INTEGER RANGE 0 TO 6			:= 0;
	SIGNAL counter		: INTEGER RANGE 0 TO 50000000	:= 0;
	SIGNAL data 		: STD_LOGIC_VECTOR (7 DOWNTO 0)	:= "00000000";
	SIGNAL data_counter	: INTEGER RANGE 0 TO 7			:= 0;
	
BEGIN

	PROCESS( clk_i,rst_i )
	BEGIN
		IF rst_i = '1' THEN
			state 			<= 0;
			counter 		<= 0;
			data 			<= "00000000";
			data_counter 	<= 0;
		ELSIF rising_edge(clk_i) THEN
			A	<=	RXD_i;
			B	<=	A;
			C	<=	B;
			CASE state IS
				WHEN 0 => 
					TXD_o	<= '1';
					IF C = '1' AND B = '0' THEN
						state	<= 1;
						counter	<= 0;
					END IF;
				WHEN 1 => 
					IF counter = N/2 THEN
						state	<= 2; -- Read start
						counter <= 0;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN 2 =>
					IF counter = N THEN
						counter				<= 0;
						data(data_counter) 	<= C;
						IF data_counter = 7 THEN
							state		 <= 3;
							data_counter <= 0;
						ELSE
							data_counter <= data_counter + 1;
						END IF;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN 3 =>
					IF counter = N THEN
						state <= 4;
						IF sw_i = '1' THEN
							data <= data + "00100000";
						ELSE
							data <= data + "00000001";
						END IF;
						TXD_o	<= '1';
						counter	<= 0;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN 4 =>
					IF counter = N THEN
						state 	<= 5;
						TXD_o	<= '0';
						counter	<= 0;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN 5 =>
					IF counter = N THEN
						counter	<= 0;
						TXD_o <= data(data_counter);
						IF data_counter = 7 THEN
							state 			<= 6;
							data_counter 	<= 0;
						ELSE
							data_counter <= data_counter + 1;
						END IF;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN 6 =>
					IF counter = N THEN
						state 	<= 0;
						TXD_o	<= '1';
						counter	<= 0;
					ELSE
						counter <= counter + 1;
					END IF;
				WHEN others =>
					state 	<= 0;
					counter <= 0;
			END CASE;
			
			END IF;
	END PROCESS;
	led_o <= data;
	
END Behavioral;

