f_gr equ p0.3	;f = fußgängerampel
f_rot equ p0.4
a_gr equ p0.0 	;a = Autoampel
a_gelb equ p0.1
a_rot equ p0.2
zaehler1 equ r7
zaehler2 equ r6
taster equ p0.7

init:
	
	mov TMOD,#00000010b
	mov tl0,#6
	mov th0,#6
	mov p0,#10000000
	setb f_rot
	setb a_gr

start:
	
	jnb taster,start
	
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