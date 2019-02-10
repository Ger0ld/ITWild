deklaration:
	
	ICM equ P1
	Ziffer0 equ 30h
	Ziffer1 equ 31h
	Ziffer2 equ 32h
	Ziffer3 equ 33h
	Digit0 equ ICM.4
	Digit1 equ ICM.5
	Digit2 equ ICM.6
	Digit3 equ ICM.7
	zaehler1 equ r7
	zaehler2 equ r6
	
	
init:
	
	mov zaehler1,#40 ;4 = 1 Sekunde verzögerung,40 = 10 Sekunden 
	mov zaehler2,#100
	mov TMOD,#00000010b
	mov th0,#6 ;Timer soll 250u Sekunden zählen
	mov tl0,#6

start:
	setb tr0
	call verz1Sek
	
	clr tr0
	jmp start
	
verz1Sek:
	jnb tf0,verz1Sek
	clr tf0
	djnz zaehler1,verz1Sek
	mov zaehler1,#40
	djnz zaehler2,verz1Sek
	mov zaehler2,#100
	ret
	
Anzeigen:

	
	
	
	mov Ziffer0,#4
	mov ICM,Ziffer0
	setb Digit0
	clr Digit0
	jmp start