//*************************************************************
// File Name:     adc.c
// Description:   Arduino ADC test program. The program will
//                read voltage from ADC Channel 0 (A0) between
//                0 and 5 volt and convert the value to 10-bit
//                binary number. The most signifiat two bits are
//                then sent to the LEDs on port B pins 0 and 1.
//
// Author:        wsilva
// Target:        Arduino UNO
// Compiler:      avr-gcc
// ************************************************************
#include <stdlib.h>
#include "mc_structs.h"

int main(){
  uint8_t number=0;
  // * Enable ADC
  // * Set Division factor to be 128, i.e., 16MHz/128 = 125kHz
  //   [ 125kHz is the sampling rate ]
  adc->ADCSRA=0x87;
  // * Set ADC Channel 0 as the source and Vcc as the reference voltage.
  // * Depending on the application, you can have a capacitor (~0.1uF)
  //   between AREF and GND to get rid of the noise
  adc->ADMUX=0x40;
  // Define the least significant two bits
  // from port B as outputs
  portb->DDR=0x03;

while (1) { // Infinite Loop

  // Start ADC conversion
  adc->ADCSRA= adc->ADCSRA | 0x40;
  // Wait for value to be ready
  while ((adc->ADCSRA&0x10) == 0 );
  // Pick the most significant 2-bits of the 10-bit value
  // that was received from ADC and assign it to number
  number=adc->ADCH & 0x0003;
  // Send the number to port b
  portb->PORT=number;
  }
return 0;
}
