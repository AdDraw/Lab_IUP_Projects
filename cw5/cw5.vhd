----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:32:38 03/06/2013 
-- Design Name: 
-- Module Name:    cw5 - Behavioral 
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

entity cw5 is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           led_o : out  STD_LOGIC);
end cw5;

architecture Behavioral of cw5 is
constant N : Integer := 9;
signal licznik:  Integer range 0 to N-1:=0; 
signal licznik2: Integer range 0 to N/2:=0;
signal zegar: std_logic:='0';
begin

process (clk_i,rst_i)
begin
if (N mod 2 = 1) then
	  if rst_i='1' then
		  licznik <= 0;
		  zegar <= '0'; 
	  elsif clk_i='1' and clk_i'event then
			 licznik <= licznik + 1;
			 licznik2 <= licznik2 + 1;
				if (licznik = N-1 or licznik2 = N/2) then
				zegar <= not zegar;
				licznik2 <= 0;
				end if;
				if licznik = N-1 then
				licznik <= 0;
				end if;
	  end if;
else
  if rst_i='1' then
     licznik2 <= 0;
	  zegar <= '0'; 
  elsif clk_i='1' and clk_i'event then
       licznik2 <= licznik2 + 1;
			if licznik2 = N/2-1  then
			zegar <= not zegar;
			licznik2 <= 0;
			end if;
  end if;
end if;
end process;
led_o <= zegar;
end Behavioral;

