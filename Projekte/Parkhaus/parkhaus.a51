deklaration:

port equ p1
schrankeRein equ port.5
schrankeRaus equ port.6
ampel equ port.7
zaehler equ r7

ljmp init

org 03h
jmp in

org 13h
jmp out




init:

	mov zaehler,#31
	mov port,zaehler
	setb EA
	setb EX0 ;Interrupt P3.2 aktiviert und Modus auf 1
	setb IT0 
	setb EX1 ;Interrupt P3.3 aktiviert und Modus auf 1
	setb IT1 
	setb ampel
	
start:

jmp start

in:
	setb p3.2
	mov a,zaehler 
	cjne a,#0,weiterIn
	reti
	weiterIn:
	setb schrankeRein
	dec zaehler
	call anzeige
	call ausgabe
	clr schrankeRein
	reti

out:
	setb p3.3
	mov a,zaehler
	cjne a,#31,weiterOut
	reti
	weiterOut:
	setb schrankeRaus
	inc zaehler
	call anzeige
	clr schrankeRaus
	reti

ausgabe:
	mov a,zaehler
	cjne a,#0,AmpelAn
	clr ampel
	ret
	AmpelAn:
	setb ampel
	ret

anzeige:
	mov a,port
	orl a,zaehler
	mov port,a
	ret


end

	