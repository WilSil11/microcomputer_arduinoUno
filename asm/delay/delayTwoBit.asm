;;**************************************************
;; File Name:        delayTwoBit.asm
;; Description:      Delay using 2-bit I/O
;; Author:           wsilva
;; Target:           Arduino UNO
;; Assembler:        avr-as
;;**************************************************

.global start
.text
#Port D will be input
.set PIND 0x09
.set DDRD 0x0A
.set PORTD 0x0B

# PORT B will be output
.set PINB 0x03
.set DDRB 0x04
.set PORTB 0x05

; delay will be calculated here
.set  repeat0, 100
.set  repeat1, 99
.set  repeat2, 200

.org 0x0000
reset_vector:
    jmp start

.org 0x0100
start:
    ldi r27, 0 ;
    ldi r17, 0x01
    ldi r18, 0x02

; port B will be used as output
    ldi r18, 0x0F
    out DDRB, r18
; port D will be used as input
    ldi r17, 0x00
    in DDRB, r17

mainLoop:

    in PORTD, r25

    ldi r25, PORTD
    andi r25, 0b00000011

    cpi r25, 3
    breq result3

    cpi r25, 2
    breq result2

    cpi r25, 1
    breq result1

result3:

    rcall delay
    rcall delay
    rcall delay
    rcall delay
    out PORTD, r17

    rcall delay
    rcall delay
    rcall delay
    rcall delay
    out PORTD, r16

    rjmp mainLoop

result2:

    rcall delay
    rcall delay
    rcall delay
    out PORTD, r17

    rcall delay
    rcall delay
    rcall delay
    out PORTD, r16
    rjmp mainLoop

result1:

    rcall delay
    rcall delay
    out PORTD, r17

    rcall delay
    rcall delay
    out PORTD, r16

    rjmp mainLoop

delay:
    ldi r18, repeat2 ; this is a direct result from the delay set from the directive

    back2:
    ldi r17, repeat1 ; the delay is pulled from the directive to rcall

    back:
    ldi r16, repeat0

    next: ; confirm the loop iteration  from the directive to determined
    dec r16
    nop
    brne next

    dec r17
    nop
    brne back

    dec r18
    nop
    brne back2

.end
