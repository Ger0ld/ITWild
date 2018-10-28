ausgabe equ p1
anz1 equ p3.7
anz2 equ p3.6
counter0 equ r7
counter1 equ r6
verzoegerung1 equ 1
start:
	mov dptr,#tabelle
	mov ausgabe , #0
	mov counter0 ,#0
loop:
	mov b,#10	
	mov a,counter0
	div AB 
	acall anzeige1
	acall timer
	acall anzeige2
	acall timer
	inc counter0
	cjne counter0 ,#100,loop
	jmp start
timer:
	mov counter1,#verzoegerung1
	djnz counter1,$
	ret
anzeige1:
	clr anz2
	acall bcd
	mov ausgabe,a
	setb anz1
	ret
anzeige2:
	clr anz1
	mov a,b
	acall bcd
	mov ausgabe,a
	setb anz2
bcd:
	movc a,@ a+dptr
	ret
tabelle:
	;	-gfedcba
	dB 01111110b	;	0
	dB 00010010b	;	1
	dB 10111100b	;	2 
	dB 10110110b	;	3
	dB 11010010b	;	4
	dB 11100110b	; 	5
	dB 11101110b	;	6
	dB 00110010b	;	7
	dB 11111110b 	;	8
	dB 11110110b 	;	9
end
	