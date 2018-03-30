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

entity adctest is
	port(
		MCLK		: in	std_logic;
		NRST		: in	std_logic;
		SCK			: in	std_logic;
		SDA			: in	std_logic;
		PWM1		: out	std_logic;
		PWM2		: out	std_logic;
		PWM3		: out	std_logic
	);
end adctest;

architecture struct of adctest is
-- COMPONENTS --
	component adcin
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			SCK			: in	std_logic;
			SDA			: in	std_logic;
			ADC1		: out	std_logic_vector(9 downto 0);
			ADC2		: out	std_logic_vector(9 downto 0);
			ADC3		: out	std_logic_vector(9 downto 0)
		);
	end component;
	component pwm10b
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			TIC			: in	std_logic;
			VALUE		: in	std_logic_vector(9 downto 0);
			PWM			: out	std_logic
		);
	end component;
	component div1024
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			TIC			: out	std_logic
		);
	end component;
	
	signal TIC : std_logic;
	signal ADC1 : std_logic_vector(9 downto 0);
	signal ADC2 : std_logic_vector(9 downto 0);
	signal ADC3 : std_logic_vector(9 downto 0);
begin
-- PORT MAP --
	I_div1024_0 : div1024
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			TIC			=> TIC
		);
	I_adcin_0 : adcin
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			SCK			=> SCK,
			SDA			=> SDA,
			ADC1		=> ADC1,
			ADC2		=> ADC2,
			ADC3		=> ADC3
		);
	I_pwm10b_1 : pwm10b
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			TIC			=> TIC,
			VALUE		=> ADC1,
			PWM			=> PWM1
		);	
	I_pwm10b_2 : pwm10b
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			TIC			=> TIC,
			VALUE		=> ADC2,
			PWM			=> PWM2
		);	
	I_pwm10b_3 : pwm10b
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			TIC			=> TIC,
			VALUE		=> ADC3,
			PWM			=> PWM3
		);	

end struct;

