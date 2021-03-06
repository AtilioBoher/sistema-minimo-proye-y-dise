; Origin set to 00000H, EOF = 00006H
		ORG  00000H

; CPU Type:
		CPU 1802

; Labels:

; Register Definitions:
R0		EQU 0
R1		EQU 1
R2		EQU 2
R3		EQU 3
R4		EQU 4
R5		EQU 5
R6		EQU 6
R7		EQU 7
R8		EQU 8
R9		EQU 9
RA		EQU 10
RB		EQU 11
RC		EQU 12
RD		EQU 13
RE		EQU 14
RF		EQU 15

; Start code segment
START
		REQ			; reset Q
INICIO
		LDI  10H	; carga 10 en D
		PHI  R1		; carga el valor de D en R1.1
LOOP
		DEC  R1		; decremanta R1
		GHI  R1		; carga el valor de R1.1 en D
		BNZ  LOOP	; salta si D = 0
		BQ   START	; salta si Q = 1
		SEQ			; set Q
ENCENDIDO
		BN4  START	; salta si EF4 está en estado bajo
		SEQ			; set Q
		BR   INICIO	; salto incondicional
		END
