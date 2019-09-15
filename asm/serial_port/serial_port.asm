;;**************************************************
;; File Name:        serial_port.asm
;; Description:      PORTB and PORTD are used in series for input/output configuration.
;; Author:           wsilva
;; Target:           Arduino UNO
;; Assembler:        avr-as
;;**************************************************

.global start
.text
# PORT D will be used for input
.set  PIND, 0x0029
.set  DDRD, 0x002A
.set  PORTD, 0x002B

# PORT B will be used for output
.set  PINB, 0x0023
.set  DDRB, 0x0024
.set  PORTB, 0x0025

.org 0x0000
reset_vector:
              jmp start     ; skip interrupt vector table

.org 0x0100
start:
              ; Set the first four bits of port B as outputs

              ldi r16, 0x0F
              sts DDRB, r16

              ; Set the first four bits of port D as inputs
              ldi r17, 0x00
              sts DDRD, r17

loop1:
              ; Read the input from port D
              lds  r18, PIND
              andi  r18, 0x10
              lds  r19, PIND
              andi  r19, 0x10
              cp r18, r19
              breq loop1
loop2:
              lds r20, PIND
              andi r20, 0x07
loop3:
              ; Read the input from port D
              lds  r18, PIND
              andi  r18, 0x10
              lds  r19, PIND
              andi  r19, 0x10
              cp r18, r19
              breq loop3
loop4:
              lds r21, PIND
              andi r21, 0x07
              add r20, r21
              sts PORTB, r20

              rjmp loop1

.end
