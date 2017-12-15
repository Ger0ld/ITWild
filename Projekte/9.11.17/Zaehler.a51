l1 equ p1.4
l2 equ p1.5
l3 equ p1.6
l4 equ p1.7
s1 equ p1.0
s2 equ p1.1

	mov p1,#11110000b

start:
	
	jbc s1,setzeL1
	jbc s2,loescheAlles
	jmp start
	
setzeL1:
	
	setb l1
	jbc s1,setzeL2	
	jmp setzeL1
	
setzeL2:
	
	setb l2
	jbc s1,setzeL3
	jmp setzeL2
	
setzeL3:
	
	setb l3
	jbc s1,setzeL4
	jmp setzeL3
	
setzeL4:

	setb l4
	jbc s2,loescheAlles	
	jmp setzeL4
	
loescheAlles:
	
	mov p1,#0
	jmp start
	end