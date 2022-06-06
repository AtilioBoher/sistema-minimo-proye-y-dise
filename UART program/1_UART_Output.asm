; Origin set to 00000H
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

; antes de empezar suponemos que el dato a enviar está cargado en el registro R2.1 (porque R0 es el contador de programa)
INICIO				; esta parte son solo definiciones
		LDI 00H
		PHI R8
		LDI 20H
		PLO R8		; se cargó 0020H en R8, que es la SUB de transmisión
		LDI 00H
		PHI R9
		LDI 40H
		PLO R9		; se cargó 0040H en R9, que es la SUB de DELAY1 (para la SUB de transmisión)
		LDI 00H
		PHI RA
		LDI 50H
		PLO RA		; se cargó 0050H en RA, que es la SUB de DELAY2 (para el programa principal)
;acá está la rutina principal
		SEQ				; empezamos ponindo la línea estado inactivo
LOOP	LDI 10101010B	; byte con bits alternantes en D
		PHI R2			; cargo el valor de D a R2
		SEP R8			; llamo a la SUB que transmite lo que está en R2
		SEP RA			; llamo a la SUB DELAY2
		SEP RA			; llamo a la SUB DELAY2
		SEP RA			; llamo a la SUB DELAY2
		BR LOOP			; salto incondicional


;---------subrutina de trasmisión de datos-------------------------
		ORG  0001FH
BACK1	SEP R0		; retorna a la subrutina principal
TRANSM
		SEQ			; Q = 1 (línea en estado inactivo)
		REQ  		; Q = 0 (bit de start)
		SEP R9		; llamar subrutina de demora de 3,33 ms
		LDI 08H		; carga el valor inmediato en D
		PLO R3		; carga el valor de D en R3.0 (este es el contador para iterar cada bit del dato en R2)
					; tiene que ser la parte baja de R3, porque DEC R3 decrementa el registro entero de 16 bits
SHIFT	GHI R2		; carga el valor de R2.1 en D (acá se supone que está el byte que queremos transmitir)
		SHL			; desplaza D a la izquierda, cargando el MSB en el bit DF
		PHI R2		; carga el valor de D en R2.1
		BNF ESCERO	; salta si DF = 0
		SEQ			; salida Q igual a 1
		SKP			; salta la siguiente instrucción de manera incondicional
ESCERO	REQ			; salida Q igual a 0
		SEP R9		; llamar subrutina de demora de 3,33 ms
		DEC R3		; decremento el contador
		GLO R3		; carga la parte baja de R3 en D
		BNZ SHIFT	; salta si D != 0
		SEQ			; Q = 1 (bit de stop) (el ingeniero Korpys dijo que ponga dos bits de stop (dos bit-time))
		SEP R9		; llamar subrutina de demora de 3,33 ms dos veces
		SEP R9
		BR BACK1	; salto incondicional





;---------subrutina de ratardo de tranmisión-------------------------
		ORG  0003FH
BACK2	SEP R8			; retorna a subrutina de transmisión 1-Byte	2-Machine Cycles	1 time
DELAY1
		LDI  050H		; carga el valor inmediato en D		2-Byte	2-Machine Cycles	1 time
		PHI  R1			; carga el valor de D en R1.1		1-Byte	2-Machine Cycles	1 time
TIMER1
		DEC  R1     	; decrementa R1						1-Byte	2-Machine Cycles	R1 times
		GHI  R1     	; carga la parte alta de R1 en D	1-Byte	2-Machine Cycles	R1 times
		BNZ  TIMER1   	; salta si D != 0					2-Byte	2-Machine Cycles	R1 times
		BR   BACK2		; salto incondicional				2-Byte	2-Machine Cycles	1 time


;---------subrutina de retardo del programa principal-------------------------
		ORG  0004FH
BACK3	SEP R0			; retorna a la rutina principal
DELAY2
		LDI  0FFH		; carga el valor inmediato en D
		PHI  R1			; carga el valor de D en R1.1
TIMER2
		DEC  R1     	; decrementa R1
		GHI  R1     	; carga la parte alta de R1 en D
		BNZ  TIMER2   	; salta si D != 0
		BR   BACK3		; salto incondicional
		END