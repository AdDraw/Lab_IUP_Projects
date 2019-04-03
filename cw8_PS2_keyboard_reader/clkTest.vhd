library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clkTest IS
    Port( 	clk_i 		: in  	STD_LOGIC;
			ps2_clk_i 	: in  	STD_LOGIC;
			clk_o 		: out  	STD_LOGIC);
END clkTest;

ARCHITECTURE Behavioral OF clkTest IS

	SIGNAL state : STD_LOGIC:='0';
	SIGNAL counter : INTEGER RANGE 0 TO 16000 :=0;
	
BEGIN

	PROCESS( clk_i )
	BEGIN
		IF rising_edge( clk_i ) THEN
				IF counter = 2000 THEN
					IF state /= '0' AND ps2_clk_i = '0' THEN
						clk_o <= '1';
					ELSE
						clk_o <= '0';
					END IF;
					state 	<= ps2_clk_i;
				ELSE
					counter <= counter + 1;
				END IF;
		END IF;
	END PROCESS;

END Behavioral;

