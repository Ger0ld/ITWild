zehner equ p3.7
einer equ p3.6
verz equ 10
verz2 equ 11111101b ;11111101b
Init:
	mov dptr, #tabelle
	clr einer
	clr zehner
	mov r1,#0
	mov r2,#0
	mov r3,#verz
Start:
;Einer anzeigen
	mov a,r1
	call bcd_7seg
	setb einer
	mov p1,a
	call timer
	clr einer
;Zehner anzeigen
	mov a,r2
	call bcd_7seg
	mov p1,a
	setb zehner
	call timer
	clr zehner
	djnz r3,start
	mov r3,#verz
	inc r1
	cjne r1,#10 , N_10
	mov r1,#0
	inc r2
N_10:
	cjne r2 ,#6 ,Start
	mov r2,#0
	jmp Start
bcd_7seg:
	movc a,@ a+dptr
	ret
timer:
	mov r4,#verz2
	loop:
	mov r5,#15	;15
	djnz r5 ,$
	djnz r4,loop
	ret
tabelle:
	;	gfabedcdp
	db 	01111110b 	;0
	db 	00010010b	;1
	db	10111100b	;2
	db	10110110b	;3
	db	11010010b	;4
	db	11100110b	;5
	db	11101110b	;6
	db	00110010b	;7
	db	11111110b	;8
	db	11110110b	;9
	db	01111110b	;10
end