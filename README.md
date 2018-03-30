# ADC-FPGA
Connect the ADC's of ATTINY13 with a FPGA (design example)

Connection between AVR and FPGA uses a unidirectional custom protocol (based on I2C) :


| start condition |         #ADC (2bit) |              ADC value (10bit) | stop condition |
|:---:	          |------	      |------           	|------	         |

AVR sends constantly a sequence for the three ADC (adc1 adc2 adc3 adc1 ...).

### Design example:

Three potentiometers enable to adjust three leds intensity using pwm feature (leds are on the FPGA board) 

![schema](https://github.com/tirfil/ADC-FPGA/blob/master/IMAGE/adctest.png)

![photo](https://github.com/tirfil/ADC-FPGA/blob/master/IMAGE/CIMG7725.JPG)
