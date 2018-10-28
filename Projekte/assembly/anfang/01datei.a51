	mov p1,#0	
Start:
	setb p1.0
	lcall Zeit 
	clr p1.0
	setb p1.1
	lcall Zeit 
	clr p1.1
	setb p1.2
	lcall Zeit 
	clr p1.2
	setb p1.3
	lcall Zeit 
	clr p1.3
	setb p1.4
	lcall Zeit 
	clr p1.4
	setb p1.5
	lcall Zeit 
	clr p1.5
	setb p1.6
	lcall Zeit 
	clr p1.6
	setb p1.7
	lcall Zeit 
	clr p1.7
	ljmp Start 
	end

Zeit:
	
	ret
	end