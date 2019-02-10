ziffer0 equ r7
ziffer1 equ r6
ziffer2 equ r5
ziffer3 equ r4
cplbit equ 20h.1h

jmp init

org 03h
jmp extern0

org 13h
jmp extern1

org 0bh
jmp timer0

init:

	mov tmod, #00000001b
	mov th0, #0D8h
	mov tl0, #0F0h
	
	setb cplbit
	setb ex0
	setb ex1
	setb et0
	setb ea
	
main:
	jmp main
	
timer0:

	mov tl0, #0ECh
	mov th0, #0D8h
	
	call anzeige
	
	inc ziffer0
	mov a,ziffer0
	cjne a,#10,return

	mov ziffer0,#0
	inc ziffer1
	mov a,ziffer1
	cjne a,#10,return

	mov ziffer1,#0
	inc ziffer2
	mov a,ziffer2
	cjne a,#10,return

	mov ziffer2,#0
	inc ziffer3
	mov a,ziffer3
	cjne a,#10,return
	
	clr et0 
	
	reti

anzeige: 
	ret

extern0:
	
	setb p3.2
	setb tr0
	cpl cplbit
	jnb cplbit,return
	clr tr0
	mov th0, #0D8h
	mov tl0, #0F0h
	mov ziffer0, #0
	mov ziffer1, #0
	mov ziffer2, #0
	mov ziffer3, #0

	return:
	reti

extern1:
	
	clr tr0
	reti