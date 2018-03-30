#include <avr/io.h>
// #include <avr/interrupt.h>
#define F_CPU 9600000UL
#include <util/delay.h>

void select_adc(uint8_t channel);
uint16_t wait_adc_result();
void send_data(uint8_t channel, uint16_t data);

void sda0();
void sda1();
void scl0();
void scl1();

int main(void)
{
	uint16_t result;
	
	// init
	// outputs PB0 = SDA, PB1 = SCL
	// others inputs
	DDRB = 0b00000011;
	PORTB = 0b00000011;
	// adc init
	ADMUX =
	(0 << 4) | (0 << 7) | (0 << REFS0) | // VCC reference
	(0 << ADLAR) | // 10 bit (left alignment)
	(0 << 3) | (0 << 2) | (0 << MUX1) | (1 << MUX0); // First channel is one	 
	ADCSRA =
	(1 << ADEN)  | // enable ADC
	(0 << ADIE)  | // no interrupt
	(0 << ADPS2) | (1 << ADPS1) | (0 << ADPS0); // scaling by 4
	
	// start
	select_adc(1);
	while(1)
	{
		result = wait_adc_result();
		select_adc(2);
		send_data(1,result);
		result = wait_adc_result();
		select_adc(3);
		send_data(2,result);
		result = wait_adc_result();
		select_adc(1);
		send_data(3,result);		
	}
	
};

void select_adc(uint8_t channel)
{
  // clear channel
  ADMUX &= 0b11111100;	
  // set channel
  ADMUX |= channel;
  // start ADC
  ADCSRA |= 1<<ADSC;
}

uint16_t wait_adc_result()
{
	uint16_t adc_result;
	//Wait
	while(ADCSRA&(1<<ADSC)); 
	// MSB
	adc_result = ADCL;
	// LSB
	adc_result |= ((uint16_t) ADCH) << 8; 
	// end of conversion
	ADCSRA |= (1<<ADIF);
	return adc_result;
}

void sda1()
{
	PORTB |= 1<<0;
	_delay_us(10);
}

void sda0()
{
	PORTB &= ~(1<<0);
	_delay_us(10);
}

void scl1()
{
	PORTB |= 1<<1;
	_delay_us(10);
}

void scl0()
{
	PORTB &= ~(1<<1);
	_delay_us(10);
}

void send_data(uint8_t channel,uint16_t data)
{
	uint8_t i;
	// start bit
	sda0();
	scl0();
	// channel
	for (i=0;i<2;i++)
	{
		if (channel & 0x02)
		{
			sda1();
			
		} else {
			sda0();

		}
		scl1();
		scl0();
		channel = channel << 1;
	}
	// data
	for (i=0;i<10;i++)
	{ 
		if (data & 0x0200)
		{
			sda1();
		} else {
			sda0();
		}
		scl1();
		scl0();
		data = data << 1;
	}
	// 0
	sda0();
	scl1();
	// stop bit
	sda1();
}
	
	
	


