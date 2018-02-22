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
	
	mov ICM,#11110000b
	mov ICM,#0
	mov zaehler1,#40 ;4 = 1 Sekunde verzögerung,40 = 10 Sekunden 
	mov zaehler2,#100	;Standart 100
	mov TMOD,#00000010b
	mov th0,#6 ;Timer soll 250u Sekunden zählen
	mov tl0,#6

start:
	;setb tr0
	;call verz1Sek
	call Anzeige
	
	inc Ziffer0
	mov a,Ziffer0
	cjne a,#10,next
	jmp mehrAls9
next:
	jmp start
mehrAls9:

	mov Ziffer0,#0

	inc Ziffer1
	
	mov a,Ziffer1
	cjne a,#6,next1
	jmp mehrAls9_1
next1:
	jmp start
mehrAls9_1:
	
	mov Ziffer1,#0
	
	inc Ziffer2
	
	mov a,Ziffer3
	cjne a,#2,weiter
	mov a,ziffer2
	cjne a,#4,weiter
	call Anzeige
	call zeit
	
	
weiter:
	mov a,Ziffer2
	cjne a,#10,next2
	jmp mehrAls9_2
next2:
	jmp start
mehrAls9_2:

	mov Ziffer2,#0
	
	inc Ziffer3
	
	mov a,Ziffer3
	cjne a,#10,next3
	jmp mehrAls9_3
next3:
	jmp start
mehrAls9_3:
	mov ziffer3,#0
	jmp	start

zeit:
	
	mov r5 , #256
	djnz r5,$
	call zeit
	ret

verz1Sek:
	
	jnb tf0,verz1Sek
	clr tf0
	djnz zaehler1,verz1Sek
	mov zaehler1,#40
	djnz zaehler2,verz1Sek
	mov zaehler2,#100
	clr tr0
	ret

Anzeige:
	mov ICM,Ziffer0
	setb Digit0
	clr Digit0
	
	mov ICM,Ziffer1
	setb Digit1
	clr Digit1
	
	mov ICM,Ziffer2
	setb Digit2
	clr Digit2
	
	mov ICM,Ziffer3
	setb Digit3
	clr Digit3
	ret
	end