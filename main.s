		#include <xc.inc>

psect code, abs
main:
		org 0x0
		goto	setup
		
		org 0x100			    ; Main code starts here at address 0x100

		; ******* Programme FLASH read Setup Code ****  
setup:		
		bcf		CFGS	; point to Flash program memory  
		bsf		EEPGD		; access Flash program memory
		movlw	0x00
		movwf	TRISC, A    ; setup C as an output
		movlw	0x00
		movwf	TRISE, A    ; setup E as an output
		movlw	0x00
		movwf	TRISF, A    ; setup F as an output
		movlw	0x00
		movwf	TRISG, A    ; setup G as an output
		movlw	0xFF
		movwf	TRISD, A    ; setup D as an input
		movlw   high(0xFFFF)
		movwf	0x20, A
		movlw	low(0xFFFF)
		movwf	0x21, A		    ; makes the delay length 0x0FFF
		movf	PORTD, W, A    ; makes the delay repeat by PORTD input
		movwf	0x22, A
		goto	start
		; ******* My data and where to put it in RAM *
myTable:
		db		0x01, 0x02, 0x04, 0x08, 0x80, 0x40, 0x20, 0x10
		myArray EQU 0x400	; Address in RAM for data
		counter EQU 0x08	; Address of counter variable
		align	2			; ensure alignment of subsequent instructions
		; ******* Main programme *********************
start:		
		lfsr	0, myArray	; Load FSR0 with address in RAM		
		movlw	low highword(myTable)	; address of data in PM
		movwf	TBLPTRU, A	; load upper bits to TBLPTRU
		movlw	high(myTable)		; address of data in PM
		movwf	TBLPTRH, A	; load high byte to TBLPTRH
		movlw	low(myTable)			; address of data in PM
		movwf	TBLPTRL, A	; load low byte to TBLPTRL
		movlw	8				; 16 bytes to read
		movwf	counter, A	; our counter register
		

loop:	
		movff	TABLAT, PORTF
		tblrd*+					; move one byte from PM to TABLAT, increment TBLPRT
		movff	TABLAT, PORTC
		movff	TABLAT, PORTE
		movff	TABLAT, POSTINC0	; move read data from TABLAT to (FSR0), increment FSR0
		call	bigdelay			; go to the delay loop
		decfsz	counter, A	; count down to zero
		
		bra		loop			; keep going until finished
		goto	0
bigdelay:
		movlw   high(0xFFFF)
		movwf	0x20, A
		movlw	low(0xFFFF)
		movwf	0x21, A				; makes the delay length 0x0FFF
		movf	PORTD, W, A	; makes the delay repeat by PORTD input
		movwf	0x22, A
		movlw	0x00
dloop:		decf	0x21, f, A
		subwfb	0x20, f, A
		
		subwfb	0x22, f, A
		bc dloop
		return
		
		end main
