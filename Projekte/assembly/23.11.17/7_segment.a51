s2 equ P2
s1 equ P1
null equ 11000000b
eins equ 11111001b
zwei equ 10100100b
drei equ 10110000b
vier equ 10011001b
fuenf equ 10010010b
sechs equ 10000010b
sieben equ 11111000b
acht equ 10000000b
neun equ 10010000b
	
	mov s2,#null
	
start:
	
	mov s1,#null
	acall sanzeige2
	mov s1,#eins
	acall sanzeige2
	mov s1,#zwei
	acall sanzeige2
	mov s1,#drei
	acall sanzeige2
	mov s1,#vier
	acall sanzeige2
	mov s1,#fuenf
	acall sanzeige2
	mov s1,#sechs
	acall sanzeige2
	mov s1,#sieben
	acall sanzeige2
	mov s1,#acht
	acall sanzeige2
	mov s1,#neun
	acall sanzeige2
	jmp start
	
sanzeige2:
	
	mov s2,#eins
	mov s2,#zwei
	mov s2,#drei
	mov s2,#vier
	mov s2,#fuenf
	mov s2,#sechs
	mov s2,#sieben
	mov s2,#acht
	mov s2,#neun
	mov s2,#null
	ret

end