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

entity tb_adcin is
end tb_adcin;

architecture stimulus of tb_adcin is

-- COMPONENTS --
	component adcin
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			SCK		: in	std_logic;
			SDA		: in	std_logic;
			ADC1		: out	std_logic_vector(9 downto 0);
			ADC2		: out	std_logic_vector(9 downto 0);
			ADC3		: out	std_logic_vector(9 downto 0)
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal NRST		: std_logic;
	signal SCK		: std_logic;
	signal SDA		: std_logic;
	signal ADC1		: std_logic_vector(9 downto 0);
	signal ADC2		: std_logic_vector(9 downto 0);
	signal ADC3		: std_logic_vector(9 downto 0);

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
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
	procedure send
		(ch : in std_logic_vector;
		 data : in std_logic_vector) is
	begin
		SCK <= '1';
		SDA <= '1';
		wait for 100 ns;
		SDA <= '0'; -- start
		wait for 100 ns;
		SCK <= '0';
		wait for 100 ns;
		for i in 1 downto 0 loop
			wait for 1 ns;
			report integer'image(i);
			SDA <= ch(1-i);
			wait for 100 ns;
			SCK <= '1';
			wait for 100 ns;
			SCK <= '0';
			wait for 100 ns;
		end loop;
		for i in 9 downto 0 loop
		    report integer'image(i);
			SDA <= data(9-i);
			wait for 100 ns;
			SCK <= '1';
			wait for 100 ns;
			SCK <= '0';
			wait for 100 ns;
		end loop;			
		SDA <= '0';
		wait for 100 ns;
		SCK <= '1';
		wait for 100 ns;
		SDA <= '1'; -- stop
		wait for 100 ns;
	end send;
	begin
		NRST <= '0';
		SCK <= '1';
		SDA <= '1';
		wait for 1000 ns;
		NRST <= '1';
		wait for 1000 ns;
        send("01","0101010101");
        send("10","1010101010");
        send("11","0011001100");
        wait for 1000 ns;
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
