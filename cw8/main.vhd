----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:19 04/02/2013 
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
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0);
           ps2_clk_i : in  STD_LOGIC;
           ps2_data_i : in  STD_LOGIC);
end main;

architecture Behavioral of main is
COMPONENT clkTest
    PORT(
         clk_i : IN  std_logic;
         ps2_clk_i : IN  std_logic;
         clk_o : OUT  std_logic
        );
    END COMPONENT;
COMPONENT display
    PORT(
         clk_i : in  STD_LOGIC;
         rst_i : in  STD_LOGIC;
         digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
         led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
         led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
COMPONENT clkGen
    PORT(
			  clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           clk_o : out  STD_LOGIC
        );
    END COMPONENT;
	 
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
constant D10 : STD_LOGIC_VECTOR(6 downto 0) := "0001000"; --abcefg
constant D11 : STD_LOGIC_VECTOR(6 downto 0) := "1100000"; --cdefg
constant D12 : STD_LOGIC_VECTOR(6 downto 0) := "0110001"; --adef
constant D13 : STD_LOGIC_VECTOR(6 downto 0) := "1000010"; --bcdeg
constant D14 : STD_LOGIC_VECTOR(6 downto 0) := "0110000"; --adefg
constant D15 : STD_LOGIC_VECTOR(6 downto 0) := "0111000"; --aefg
Type tablica is Array (0 to 9) of STD_LOGIC_VECTOR(6 downto 0);
Constant Table: tablica:=(D00,D01,D02,D03,D04,D05,D06,D07,D08,D09);

signal clock: STD_LOGIC;
signal clk_display: STD_LOGIC;
signal stan: integer range 0 to 15:=0;
signal licznik: integer range 0 to 15;
signal licznik2: integer range 0 to 15;
signal dane: STD_LOGIC_VECTOR (7 downto 0);
signal cyfry: STD_LOGIC_VECTOR (31 downto 0):="11111111111111111111111111111111";

begin
   uut0: clkTest PORT MAP (
          clk_i => clk_i,
          ps2_clk_i => ps2_clk_i,
          clk_o => clock
        );
	uut1: display PORT MAP (
          clk_i => clk_display,
          rst_i => rst_i,
			 digit_i => cyfry,
          led7_an_o => led7_an_o,
			 led7_seg_o => led7_seg_o
        );
	uut2: clkGen PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
			 clk_o => clk_display
        );
process(rst_i,clock)
begin
if rst_i='1' then
cyfry(7 downto 1) <= "1111111";
elsif rising_edge(clock) then
	if licznik2=15 then
	licznik2 <= 0;
	else
	licznik2 <= licznik2 + 1;
	end if;
	if stan=0 then
		if ps2_data_i = '0' then
		stan <=1;
		end if;
	elsif stan=1 then
		dane(licznik) <= ps2_data_i;
		if licznik = 7 then
			stan <= 2;
			licznik <= 0;
		else
			licznik <= licznik + 1;
		end if;
	elsif stan=2 then
		stan <= 3;
	elsif stan=3 then
	       case dane is
          when "01000101" => 
			 cyfry(7 downto 1) <= D00;
          when "00010110" => 
			 cyfry(7 downto 1) <= D01;
			 when "00011110" => 
			 cyfry(7 downto 1) <= D02;
			 when "00100110" => 
			 cyfry(7 downto 1) <= D03;
			 when "00100101" => 
			 cyfry(7 downto 1) <= D04;
			 when "00101110" => 
			 cyfry(7 downto 1) <= D05;
			 when "00110110" => 
			 cyfry(7 downto 1) <= D06;
			 when "00111101" => 
			 cyfry(7 downto 1) <= D07;
			 when "00111110" => 
			 cyfry(7 downto 1) <= D08;
			 when "01000110" => 
			 cyfry(7 downto 1) <= D09;
			 when "00011100" => 
			 cyfry(7 downto 1) <= D10;
			 when "00110010" => 
			 cyfry(7 downto 1) <= D11;
			 when "00100001" => 
			 cyfry(7 downto 1) <= D12;
			 when "00100011" => 
			 cyfry(7 downto 1) <= D13;
			 when "00100100" => 
			 cyfry(7 downto 1) <= D14;
			 when "00101011" => 
			 cyfry(7 downto 1) <= D15;
          when others =>
			 cyfry(7 downto 1) <= "1010101";
       end case;
	stan <=0;
	end if;
end if;
end process;

end Behavioral;

