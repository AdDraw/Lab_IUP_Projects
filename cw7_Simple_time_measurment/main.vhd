----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:38 03/27/2013 
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
    Port ( start_stop_button_i : in  STD_LOGIC;
           clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
constant D00 : STD_LOGIC_VECTOR(6 downto 0) := "0000001"; --abcdef-
constant D01 : STD_LOGIC_VECTOR(6 downto 0) := "1001111"; --bc
constant D02 : STD_LOGIC_VECTOR(6 downto 0) := "0010010"; --abdeg
constant D03 : STD_LOGIC_VECTOR(6 downto 0) := "0000110"; --abcdg
constant D04 : STD_LOGIC_VECTOR(6 downto 0) := "1001100"; --bcfg
constant D05 : STD_LOGIC_VECTOR(6 downto 0) := "0100100"; --acdfg
constant D06 : STD_LOGIC_VECTOR(6 downto 0) := "0100000"; --acdefg
constant D07 : STD_LOGIC_VECTOR(6 downto 0) := "0001111"; --abc
constant D08 : STD_LOGIC_VECTOR(6 downto 0) := "0000000"; --abcdefg
constant D09 : STD_LOGIC_VECTOR(6 downto 0) := "0000100"; --abcdefg
--constant BN : Integer := 50; --abcdefg
Type tablica is Array (0 to 9) of STD_LOGIC_VECTOR(6 downto 0);
Constant Table: tablica:=(D00,D01,D02,D03,D04,D05,D06,D07,D08,D09);
signal Digit:  STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001";
signal Clock:  STD_LOGIC := '0';
signal Button:  STD_LOGIC := '0';
signal Stan: Integer range 0 to 3 := 0;

--signal B_enam: Integer range 0 to BN := BN;
Component Clkgen 
 Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           clk_o : out  STD_LOGIC);
END Component;
Component Display
	 Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
END Component;
signal licznik:  Integer range 0 to 9:=0;
signal licznik0:  Integer range 0 to 9:=0;
signal licznik1:  Integer range 0 to 9:=0;
signal licznik2:  Integer range 0 to 9:=0;
signal licznik3:  Integer range 0 to 9:=0;
begin
uut0: Clkgen PORT MAP(
                  clk_i => clk_i,
                  rst_i => rst_i,
						clk_o => Clock
);
uut1: Display PORT MAP(
                  clk_i => Clock,
                  rst_i => rst_i,
						digit_i => Digit,
						led7_an_o => led7_an_o,
						led7_seg_o => led7_seg_o
);
--Stan 0 - gotowoœæ 1 - liczenie 2 - stop 3 - przepe³nienie(stop)
process (Clock,rst_i)
begin
  if rst_i='1' then
          	Stan <= 0;
				--B_enam <= BN;
				Button <= '1';
				licznik <= 0;
				licznik0 <= 0;
				licznik1 <= 0;
				licznik2 <= 0;
				licznik3 <= 0;
  elsif rising_edge(Clock) then
  if start_stop_button_i='1' and Button='0' then
  case Stan is
  when 0 =>   Stan <= 1;
  when 1 =>   Stan <= 2;
  when others => Stan <= 0;
				licznik <= 0;
				licznik0 <= 0;
				licznik1 <= 0;
				licznik2 <= 0;
				licznik3 <= 0;
end case;
  --B_enam <= 0;
  --else
	--	if B_enam<BN then
	--		B_enam <= B_enam + 1;
	--	end if;
  end if;
  
  Button <= start_stop_button_i;
          	if Stan =1  then
					if licznik<9 then
					licznik <= licznik + 1;
					else
						licznik <=0;
						if licznik0<9 then
						licznik0 <= licznik0 + 1;
						else
						licznik0 <=0;
							if licznik1<9 then
							licznik1 <= licznik1 + 1;
							else
							licznik1 <=0;
								if licznik2<9 then
								licznik2 <= licznik2 + 1;
								else
								licznik2 <=0;
									if licznik3<5 then
									licznik3 <= licznik3 + 1;
									else
									Stan <= 3;
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
  end if;
end process;

Digit(7 downto 0) <= Table(licznik0) & '1' when Stan<3 else "11111101";	
Digit(15 downto 8) <= Table(licznik1) & '1' when Stan<3 else "11111101";	
Digit(23 downto 16) <= Table(licznik2) & '0' when Stan<3 else "11111100";	
Digit(31 downto 24) <= Table(licznik3) & '1' when Stan<3 else "11111101";	


end Behavioral;

