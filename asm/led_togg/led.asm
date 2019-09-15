	;;   turns on an LED on digital output 13

	.set PINB,     0x09
	.set DDRB,     0x0A
	.set TCCR0B,   0x25
	.set TCNT0,	   0x26
	.set LED_MASK, 0b11111100
	.set LED_MASK2,0b11111110
	.set PS_1024,  0b00000101

	setup:
	    ldi r16, PS_1024    ; Set r16 with prescaler 1024 value
	    out TCCR0B, r16     ; Set the TCCROB to 1024
	    ldi r16, LED_MASK2  ; Set r16 to the LED bit
	    out DDRB, r16       ; Set LED pin to output
	    ldi r16, LED_MASK   ; Set r16 to the LED bit
	    clr r18             ; Clear the saved timer
	loop:
	    ldi r20, 61         ; Initialize our software counter
	check_timer:
	    in r17, TCNT0       ; Read the timer
	    cp r17, r18         ; Compare with previous value
	    mov r18, r17        ; Save current value
	    brsh check_timer    ; unless the timer has decreased, repeat
	decrement:
	    dec r20             ; decrement the software counter
	    brne check_timer    ; if not zero, go back to checking the timer
toggle:
	in  r22, PINB
	lsl r22
	or  r22	, r16
	    out PINB, r22       ; toggle the LED
	    rjmp loop
