; Origin set to 00000H, EOF = 0000DH
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
;------------------------------------------------------
INICIO1
		REQ
START1
		LDI  010H ;al parecer el cero va adelante para indicar que es hexadecimal
		PHI  R1
LOOP1
		DEC  R1
		GHI  R1
		BNZ  LOOP1
		BQ   INICIO1
		SEQ
		BR   START1

;----------------------------------------------------
		ORG  00100H
START2
		REQ
ENCENDIDO2
		BN1  START2
		SEQ
		BR   ENCENDIDO2


;-------------------------------------------------------
		ORG  00200H
START3
		REQ
INICIO3
		LDI  10H
		PHI  R1
LOOP3
		DEC  R1
		GHI  R1
		BNZ  LOOP3
		BQ   START3
		SEQ
ENCENDIDO3
		BN1  START3
		SEQ
		BR   INICIO3

;-----------------------------------------------------------
		ORG   00300H
START4
		LDI  05H  
WAIT4
		BN1  WAIT4    
HOLD4
		B4   HOLD4
		SMI  01H
		BNZ  WAIT4
ENCENDIDO4
		SEQ
		BR   ENCENDIDO4
		END
