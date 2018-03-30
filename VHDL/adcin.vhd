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

entity adcin is
	port(
		MCLK		: in	std_logic;
		NRST		: in	std_logic;
		SCK			: in	std_logic;
		SDA			: in	std_logic;
		ADC1		: out	std_logic_vector(9 downto 0);
		ADC2		: out	std_logic_vector(9 downto 0);
		ADC3		: out	std_logic_vector(9 downto 0)
	);
end adcin;

architecture rtl of adcin is
signal SCK_S : std_logic;
signal SDA_S : std_logic;
signal SCK_Q : std_logic;
signal SDA_Q : std_logic;
signal SCK_SS : std_logic;
signal SDA_SS : std_logic;
signal start_cond : std_logic;
signal stop_cond : std_logic;
signal rise : std_logic;
signal fall : std_logic;
signal data : std_logic_vector(11 downto 0);
signal reg : std_logic;
type t_state is (S_IDLE,S_START,S_CAPTURE,S_END);
signal state : t_state;
begin

	RESYNC: process(MCLK, NRST)
	begin
		if (NRST = '0') then
			SCK_Q <= '1';
			SCK_S <= '1';
			SDA_Q <= '1';
			SDA_S <= '1';
			SCK_SS <= '0';
			SDA_SS <= '0';
		elsif (MCLK'event and MCLK = '1') then
			SCK_Q <= SCK;
			SCK_S <= SCK_Q;
			SDA_Q <= SDA;
			SDA_S <= SDA_Q;
			SCK_SS <= SCK_S;
			SDA_SS <= SDA_S;
		end if;
	end process RESYNC;
	
	start_cond <= SCK_S and (not(SDA_S) and SDA_SS);
	stop_cond <= SCK_S and (SDA_S and not(SDA_SS));
	
	rise <= SCK_S and not(SCK_SS);
	fall <= not(SCK_S) and SCK_SS;
	
	OTO: process (MCLK,NRST)
	begin
		if (NRST = '0') then
			data <= (others=>'0');
			ADC1 <= (others=>'0');
			ADC2 <= (others=>'0');
			ADC3 <= (others=>'0');
			reg <= '0';
			state <= S_IDLE;
		elsif (MCLK'event and MCLK = '1') then
			if (state = S_IDLE) then
				if (start_cond='1') then
					data <= (others=>'0');
					reg <= '0';
					state <= S_START;
				end if;
			elsif (state = S_START) then
				if (fall = '1') then
					state <= S_CAPTURE;
				end if;
			elsif (state = S_CAPTURE) then
				if (rise = '1') then
					reg <= SDA_S;
				elsif (fall = '1') then
					data(0) <= reg;
					data(11 downto 1) <= data(10 downto 0);
				elsif (stop_cond = '1') then
					state <= S_END;
				end if;
			elsif (state = S_END) then
				case data(11 downto 10) is
					when "01" => ADC1 <= data(9 downto 0);
					when "10" => ADC2 <= data(9 downto 0);
					when "11" => ADC3 <= data(9 downto 0);
					when others =>
				end case;
				state <= S_IDLE;
			end if;
		end if;
	end process OTO;
end rtl;

