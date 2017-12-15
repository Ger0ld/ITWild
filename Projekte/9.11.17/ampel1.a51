f_gr equ p1.3
f_rot equ p1.4
a_gr equ p1.0
a_gelb equ p1.1
a_rot equ p1.2

	mov p1,#0
	setb f_rot
	setb a_gr
start:
	
	acall time 
	clr a_gr
	setb a_gelb
	acall time
	
	clr a_gelb
	setb a_rot
	clr f_rot
	setb f_gr
	acall time
	
	clr f_gr
	setb f_rot
	setb a_rot
	setb a_gelb
	acall time
	
	clr a_rot 
	clr a_gelb
	setb a_gr
	jmp start
	
time:
	mov r7,#10
	djnz r7,$
	ret
	end