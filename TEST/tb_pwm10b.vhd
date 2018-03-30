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

entity tb_pwm10b is
end tb_pwm10b;

architecture stimulus of tb_pwm10b is

-- COMPONENTS --
	component pwm10b
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			TIC			: in	std_logic;
			VALUE		: in	std_logic_vector(9 downto 0);
			PWM			: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal NRST		: std_logic;
	signal TIC		: std_logic;
	signal VALUE	: std_logic_vector(9 downto 0);
	signal PWM		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_pwm10b_0 : pwm10b
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			TIC		=> TIC,
			VALUE		=> VALUE,
			PWM		=> PWM
		);

--
	CLOCK: process
	begin
		while (RUNNING = '1') loop
			MCLK <= '1';
			wait for 10 ns;
			MCLK <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process CLOCK;

	GO: process
	begin
		NRST <= '0';
		TIC <= '1';
		VALUE <= "1000000000";
		wait for 1000 ns;
		NRST <= '1';
		wait for 21000 ns;
		VALUE <= "1111111111";
		wait for 21000 ns;
		VALUE <= "0000000000";
		wait for 21000 ns;
		wait for 21000 ns;
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
