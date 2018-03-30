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

entity pwm10b is
	port(
		MCLK		: in	std_logic;
		NRST		: in	std_logic;
		TIC			: in	std_logic;
		VALUE		: in	std_logic_vector(9 downto 0);
		PWM			: out	std_logic
	);
end pwm10b;

architecture rtl of pwm10b is
signal counter : integer range 0 to 1023;
signal maximum : std_logic_vector(9 downto 0);
begin

	PCO: process(MCLK, NRST)
	begin
		if (NRST = '0') then
			counter <= 0;
			maximum <= (others => '0');
		elsif (MCLK'event and MCLK = '1') then
			if (TIC = '1') then
				if (counter = 1023) then
					maximum <= VALUE;
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;

	end process PCO;
	
	PPWM: process(MCLK, NRST)
	begin
		if (NRST = '0') then
			PWM <= '0';
		elsif (MCLK'event and MCLK = '1') then
			if (TIC = '1') then
				if (to_integer(unsigned(maximum)) = 1023) then
					PWM <= '1';
				elsif (counter = to_integer(unsigned(maximum))) then
					PWM <= '0';
				elsif (counter = 0) then
					PWM <= '1';
				end if;
			end if;
		end if;
	end process PPWM;
	
end rtl;

