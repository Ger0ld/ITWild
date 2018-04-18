anz0 equ p1.0
anz1 equ p1.1
counter equ r7
counter1 equ r6
counter2 equ r3
zeitv1 equ r5
zeitv2 equ r4


	jmp start
	org 0bh 
	jmp interrupt0
	org 1bh
	jmp interrupt1

Start:
	
	mov counter,#167
	mov counter2,#0
	mov zeitv1,#0
	mov zeitv2,#0
	mov TMOD,#00100010b
	setb ea
	setb et1
	setb et0
	mov tl1,#11110010b
	mov th1,#110000b
	mov tl0,#6
	mov th0,#6
	setb tr0
	setb tr1
	
Loop:

	call zeit
	jmp loop
	
zeit:
	
	djnz zeitv1,zeit
	djnz zeitv2,zeit
	ret
	
interrupt0:
	djnz counter,return
	inc counter2
	mov a,counter2
	cjne a,#10,return
	mov counter,#167
	mov counter2,#0
	cpl anz0
return:
	reti

interrupt1:
	mov tl1,#11110010b
	mov th1,#110000b
	inc counter1
	mov a,counter1
	cjne a,#10,return
	mov counter1,#0
	cpl anz1
	reti