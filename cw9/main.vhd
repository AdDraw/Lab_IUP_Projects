----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:43 04/17/2013 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           TXD_o : out  STD_LOGIC;
           RXD_i : in  STD_LOGIC;
			  sw_i : in  STD_LOGIC;
           led_o : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end main;

architecture Behavioral of main is
signal A: STD_LOGIC:='0';
signal B: STD_LOGIC:='0';
signal C: STD_LOGIC:='0';
signal stan: integer range 0 to 6:=0;
signal licznik: integer range 0 to 50000000:=0;
constant N: integer:=5208;
signal dane :  STD_LOGIC_VECTOR (7 downto 0):="00000000";
signal licznik_dane: integer range 0 to 7:=0;
begin
process(clk_i,rst_i)
begin
	if rst_i='1' then
	stan <= 0;
	licznik <= 0;
	dane <= "00000000";
	licznik_dane <= 0;
	elsif rising_edge(clk_i) then
		A<=RXD_i;
		B<=A;
		C<=B;
		case stan is
          when 0 => 
			 TXD_o<='1';
			 if C='1' and B='0' then
				stan<=1;
				licznik<=0;
			 end if;
			 when 1 => 
			 if licznik=N/2 then
				stan<=2; -- Pocz¹tek odczytu
				licznik <= 0;
				else
				licznik <= licznik + 1;
				end if;
			 when 2 =>
			   if licznik=N then
						licznik<=0;
						dane(licznik_dane) <= C;
					if licznik_dane=7 then
						stan <= 3;
						licznik_dane <=0;
					else
					licznik_dane <= licznik_dane + 1;
					end if;
				else
					licznik <= licznik + 1;
				end if;
			 when 3 =>
				if licznik=N then
					stan <= 4;
					if sw_i = '1' then
					dane <= dane + "00100000";
					else
					dane <= dane + "00000001";
					end if;
					TXD_o<='1';
					licznik<=0;
				else
					licznik <= licznik + 1;
				end if;
			 when 4 =>
				if licznik=N then
					stan <= 5;
					TXD_o<='0';
					licznik<=0;
				else
					licznik <= licznik + 1;
				end if;
			 when 5 =>
				if licznik=N then
					licznik<=0;
						TXD_o <= dane(licznik_dane);
						if licznik_dane=7 then
							stan <= 6;
							licznik_dane <=0;
						else
						licznik_dane <= licznik_dane + 1;
						end if;
				else
					licznik <= licznik + 1;
				end if;
				when 6 =>
				if licznik=N then
					stan <= 0;
					TXD_o<='1';
					licznik<=0;
				else
					licznik <= licznik + 1;
				end if;
          when others =>
				stan <= 0;
				licznik <=0;
       end case;
		
			
		end if;
		
end process;
led_o <= dane ;
end Behavioral;

