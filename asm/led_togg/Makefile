ledmake:
	avr-as -mmcu=atmega328p -o led.o led.asm
	avr-ld -o led.elf led.o
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature led.elf led.hex
#	avra led.asm
	sudo avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:led.hex
