--###############################
--# Project Name : 
--# File         : 
--# Author       : 
--# Description  : 
--# Modification History
--#
--###############################

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity div1024 is
	port(
		MCLK		: in	std_logic;
		NRST		: in	std_logic;
		TIC			: out	std_logic
	);
end div1024;

architecture rtl of div1024 is
signal counter : integer range 0 to 1023;
begin

	PC: process(MCLK, NRST)
	begin
		if (NRST = '0') then
			counter <= 0;
			TIC <= '0';
		elsif (MCLK'event and MCLK = '1') then
			if (counter = 1023) then
				counter <= 0;
				TIC <= '1';
			else
				counter <= counter + 1;
				TIC <= '0';
			end if;
		end if;
	end process PC;

end rtl;

