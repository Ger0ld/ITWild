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
	
	
	inc Ziffer0
	mov a,Ziffer0
	cjne a,#10,next
	jmp mehrAls9
next:
	call Ausgabe0
	jmp start
mehrAls9:

	mov Ziffer0,#0
	
	call Ausgabe0
	
	

	inc Ziffer1
	
	mov a,Ziffer1
	cjne a,#10,next1
	jmp mehrAls9_1
next1:
	call Ausgabe1
	jmp start
mehrAls9_1:
	

	mov Ziffer1,#0
	call Ausgabe1
	
	inc Ziffer2
	mov a,Ziffer2
	cjne a,#10,next2
	jmp mehrAls9_2
next2:
	call Ausgabe2
	jmp start
mehrAls9_2:

	mov Ziffer2,#0
	call Ausgabe2
	
	inc Ziffer3
	
	mov a,Ziffer3
	cjne a,#10,next3
	jmp mehrAls9_3
next3:
	call Ausgabe3
	jmp start
mehrAls9_3:
	
	mov Ziffer3,#0
	call Ausgabe3
	jmp start

kleinerAls:
	



ret



zeit:
	ret
	mov r5 , #5
	djnz r5,$
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

Ausgabe0:
	;call zeit
	mov ICM,Ziffer0
	setb Digit0
	clr Digit0
	ret
Ausgabe1:
	;call zeit
	mov ICM,Ziffer1
	setb Digit1
	clr Digit1
	ret
Ausgabe2:
	;call zeit
	mov ICM,Ziffer2
	setb Digit2
	clr Digit2
	ret
Ausgabe3:
	;call zeit
	mov ICM,Ziffer3
	setb Digit3
	clr Digit3
	ret
	end