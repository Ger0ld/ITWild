setzen equ p1.0
loeschen equ p1.1
lampe1 equ p1.4
lampe2 equ p1.5
lampe3 equ p1.6
lampe4 equ p1.7
	
	
init:

	mov p1,#0

start:	

	jb setzen,l1
	jmp start
	
l1:	

	clr setzen
	setb lampe1
	jb setzen,l2
	jmp l1
	
l2:

	clr setzen
	setb lampe2
	jb setzen,l3
	jmp l2
	
l3:

	clr setzen
	setb lampe3
	jb setzen,l4
	jmp l3
	

l4:

	clr setzen
	setb lampe4

partylichter:
	
	clr lampe1
	clr lampe2
	clr lampe3
	clr lampe4
	setb lampe1
	setb lampe2
	setb lampe3
	setb lampe4
	jb loeschen,init
	jmp partylichter
	
end