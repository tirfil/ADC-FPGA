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

entity tb_adctest is
end tb_adctest;

architecture stimulus of tb_adctest is

-- COMPONENTS --
	component adctest
		port(
			MCLK		: in	std_logic;
			NRST		: in	std_logic;
			SCK		: in	std_logic;
			SDA		: in	std_logic;
			PWM1		: out	std_logic;
			PWM2		: out	std_logic;
			PWM3		: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal NRST		: std_logic;
	signal SCK		: std_logic;
	signal SDA		: std_logic;
	signal PWM1		: std_logic;
	signal PWM2		: std_logic;
	signal PWM3		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_adctest_0 : adctest
		port map (
			MCLK		=> MCLK,
			NRST		=> NRST,
			SCK		=> SCK,
			SDA		=> SDA,
			PWM1		=> PWM1,
			PWM2		=> PWM2,
			PWM3		=> PWM3
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
        send("01","1000000000");
        send("10","0000000000");
        send("11","1111111111");
        wait for 70000000 ns;
        send("01","0000000001");
        send("11","0000000000");
        send("10","1111111111");       
        wait for 30000000 ns;
        send("01","0000000001");
        send("11","0000000000");
        send("10","1111111110"); 
        wait for 30000000 ns;       
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
