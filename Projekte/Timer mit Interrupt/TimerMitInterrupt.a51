Offset equ 0h
org offset
ausg0 equ p1.0
ausg1 equ p1.1
ausg2 equ p1.3
zaehler equ r5
zaehler1 equ r4
zaehler2 equ r3
port equ p2

ljmp start

org offset+1bh
jmp IRoutine

org offset+0bh
jmp timer0

start:
	mov zaehler1,#167
	mov zaehler2,#4
	mov zaehler,#0
	mov tmod,#00010010b
	mov tl0,#6
	mov th0,#6
	mov TH1,#3Ch
	mov TL1,#0B0h
	setb et1
	setb ea
	setb tr1
	setb tr0

schleife:
	
	cpl ausg0
	;acall zeit
	ljmp schleife

Zeit:
	mov r7,#0
	mov r6,#0
hier:
	djnz r6,hier
	djnz r7,hier
	ret
	
IRoutine: ;Steuerung von ausg1
	mov TL1,#0AEh ;Nachladen - 2 MZ wegen mov
	mov TH1,#3Ch
	inc zaehler
	mov a,zaehler
	;cjne a,port,return ;Steuerung mit Port2
	cjne a,#10,return ;Blinkt alle 0,5 sec
	mov zaehler,#0
	cpl ausg1 
return:
	reti
	
timer0:
	
	reti
end