MCU=attiny13
F_CPU=9600000
CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-std=c99 -Wall -g -Os -mmcu=${MCU} -DF_CPU=${F_CPU} -I.
TARGET=muxadc
SRCS=muxadc.c

all:
		${CC} ${CFLAGS} -o ${TARGET}.bin ${SRCS}
		${OBJCOPY} -j .text -j .data -O ihex ${TARGET}.bin ${TARGET}.hex
flash:
		avrdude -p ${MCU} -c usbasp -U flash:w:${TARGET}.hex:i -F -P usb -b2000
clean:
		rm -f *.bin *.hex
size:
		avr-size -C ${TARGET}.bin --mcu=${MCU}
