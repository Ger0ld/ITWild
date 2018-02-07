f_gr equ p1.3	;f = fußgängerampel
f_rot equ p1.4
a_gr equ p1.0 	;a = Autoampel
a_gelb equ p1.1
a_rot equ p1.2
zaehler1 equ r7
zaehler2 equ r6
taster equ p1.7

init:
		mov TMOD,#00000010b
	mov tl0,#6
	mov th0,#6
	mov p1,#0
	setb f_rot
	setb a_gr

start:
	
	;jb taster,start
	
	call zeitLang
	;Autoampel auf Gelb
	clr a_gr
	setb a_gelb
	
	call zeitKurz
	;Autoampel auf Rot und Fußgängerampel auf Grün
	clr a_gelb
	setb a_rot
	clr f_rot
	setb f_gr
	
	call zeitLang
	
	;Fußgängerampel auf Rot und Autoampel auf Rot-Gelb
	clr f_gr
	setb f_rot
	setb a_rot
	setb a_gelb
	
	call zeitKurz
	
	;Autoampel auf Grün
	clr a_rot 
	clr a_gelb
	setb a_gr
	
	;Zurück zum Anfang
	jmp start
	
	
zeitLang: 

	mov zaehler1,#80
	mov zaehler2,#20
	loopL:
	djnz zaehler1,$
	mov zaehler1,#40 
	djnz zaehler2,loopL
	ret



zeitKurz: 
	mov zaehler1,#40
	mov zaehler2,#10
	loopK:
	djnz zaehler1,$
	mov zaehler1,#40 
	djnz zaehler2,loopK
	ret
	end