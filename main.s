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
		movwf	TRISH, A    ; setup H as an output 
		movlw	0x00
		movwf	TRISF, A    ; setup F as an output
		movlw	0x00
		movwf	TRISG, A    ; setup G as an output
		movlw	0xFF
		movwf	TRISE, A    ; setup E as an input
		movlw   high(0xFFFF)
		movwf	0x20, A
		movlw	low(0xFFFF)
		movwf	0x21, A		    ; makes the delay length 0x0FFF
		movf	PORTE, W, A    ; makes the delay repeat by PORTE input
		movwf	0x22, A
		; ******* Triangle Wave Generator Variables ****
		waveValue EQU 0x08	; Address of waveform value (0-255)
		direction EQU 0x09	; Address of direction flag (0=increment, 1=decrement)
		align	2			; ensure alignment of subsequent instructions
		; ******* Main programme *********************
		call SPI_MasterInit
		goto	start

start:		
		movlw	0x00
		movwf	waveValue, A	; Initialize waveform value to 0
		movlw	0x00
		movwf	direction, A	; Initialize direction to increment (0)

loop:	
	movf	waveValue, W, A	; Output current waveform value to Working Register
	call	SPI_MasterTransmit
		call	bigdelay			; Variable delay controlled by PORTE input
		
		
		; Check current direction and update waveform value
		movf	direction, W, A	; Load direction flag
		btfsc	STATUS, 2, A		; Skip if incrementing (direction = 0) - Z flag is bit 2
		bra		increment		; Branch to increment if direction = 0
		bra		decrement		; Branch to decrement if direction = 1
		
increment:
		movf	waveValue, W, A	; Load waveform value to check if at 255
		sublw	0xFF			; Subtract from 255 (W = 255 - waveValue)
		btfsc	STATUS, 2, A	; Skip next if waveValue is 255 (need to change direction) - Z flag is bit 2
		bra		change_dir_dec	; Change to decrement direction if at 255
		incf	waveValue, F, A	; Increment waveform value
		bra		continue		; Continue loop
		
decrement:
		movf	waveValue, W, A	; Load waveform value to check if reached 0
		btfsc	STATUS, 2, A	; Skip next if waveValue is 0 (need to change direction) - Z flag is bit 2
		bra		change_dir_inc	; Change to increment direction if at 0
		decf	waveValue, F, A	; Decrement waveform value
		bra		continue		; Continue loop
		
change_dir_inc:
		movlw	0x00
		movwf	direction, A	; Set direction to increment
		bra		continue
		
change_dir_dec:
		movlw	0x01
		movwf	direction, A	; Set direction to decrement
		bra		continue
		
continue:
		bra		loop			; Loop forever
bigdelay:
		movlw   high(0xFFFF)
		movwf	0x20, A
		movlw	low(0xFFFF)
		movwf	0x21, A				; makes the delay length 0x0FFF
		movf	PORTE, W, A	; makes the delay repeat by PORTE input
		movwf	0x22, A
		movlw	0x00
dloop:		decf	0x21, f, A
		subwfb	0x20, f, A
		
		subwfb	0x22, f, A
		bc dloop
		return
		
SPI_MasterInit:        ; Set Clock edge to negative
		bcf     CKE2       ; CKE bit in SSP2STAT,
		; MSSP enable; CKP=1; SPI master, clock=Fosc/64 (1MHz)
		movlw   (SSP2CON1_SSPEN_MASK)|(SSP2CON1_CKP_MASK)|(SSP2CON1_SSPM1_MASK)
		movwf   SSP2CON1, A
		; SDO2 output; SCK2 output
		bcf     TRISD, PORTD_SDO2_POSN, A  ; SDO2 output
		bcf     TRISD, PORTD_SCK2_POSN, A  ; SCK2 output
		return

SPI_MasterTransmit:    ; Start transmission of data (held in W)
	movwf   SSP2BUF, A     ; write data to output buffer
Wait_Transmit:         ; Wait for transmission to complete
	btfss   PIR2, 5, A     ; check interrupt flag to see if data has been sent
	bra     Wait_Transmit
	bcf     PIR2, 5, A     ; clear interrupt flag
	return
	
	end main