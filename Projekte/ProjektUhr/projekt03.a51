ziffer0 equ r5
ziffer1 equ r4

jmp init

org 1bh 
jmp IR

org 13h
jmp ir1

org 03h
jmp ir2

init:

	mov tmod ,#00010000b
	mov th1,#0d8h
	mov tl1,#0f0h
	setb et1
	setb ex1
	setb ex0
	setb it0
	setb ea
		
main:

	jmp main
	
IR:
	mov tl1,#0e4h
	mov th1,#0d8h
	inc ziffer0
	inc r7
	mov A,R7
	subb A,#10
	jnz return
	mov r7,#0
	inc ziffer1
	return:
	reti
	
ir1:
	cpl p3.7
	jb p3.7,sprung
	setb tr1
	sprung:
	clr tr1
	mov th1,#0d8h
	mov tl1,#0f0h
	mov ziffer0,#0
	mov ziffer1,#0
	mov r7,#0
	reti

ir2:
