init:
	
	mov tmod,#00000010b
	setb tr0

start:
	jnb tf0,start
	clr tf0 
	inc r7
	jmp start
end
	