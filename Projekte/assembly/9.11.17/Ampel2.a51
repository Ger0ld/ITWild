f_gr equ p1.3
f_rot equ p1.4
a_gr equ p1.0
a_ge equ p1.1
a_rot equ p1.2
f_taste equ p1.7
Ampel equ P1

reset:
	mov Ampel,#10000000b
	setb f_rot
	setb a_gr
	jmp start
	
start:	
	
	jnb f_taste,fgr		;falls die Taste angeschalten wird für die fußgänger grün geschalten und die Taste wieder auf aus
	jmp start
fgr:
	
	clr a_gr
	setb a_ge
	acall zeit
	clr a_ge
	setb a_rot
	clr f_rot
	setb f_gr
	acall zeit
	setb a_ge
	jmp reset
zeit:
	mov r7,#10
	djnz r7,$
	ret
	end