.define Cii
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine converts integers to integers.
! Convertions of integers with the same source size as destination
! size aren't done, there just return the source.
! A convertion from 4 bytes to 2 bytes just strips the two
! most significant bytes.
! A convertion from 2 bytes to 4 bytes tests the sign of the
! source so that sign extentension takes place if neccesairy.


Cii:
	tsx
	ldx 0,x		! get return address
	ins
	ins
	cmpb #1
	beq Cii_1	! a conversion from ? to 1
	cmpb #2
	beq Cii_2	! a conversion from ? to 2
	pula		! a conversion from ? to 4
	pulb
	cmpb #4
	beq 8f		! a conversion 4 to 4 (skip)
	cmpb #1
	bne 2f
	pula		! a conversion 1 to 4
	pulb
	pshb
	clra
	aslb
	sbca #0
	psha
	psha
	psha
	jmp 0,x
2:	pulb		! a conversion 2 to 4
	pshb
	clra
	aslb
	sbca #0		! sign extend
7:	psha
	psha
8:	jmp 0,x
Cii_1:			! a conversion from ? to 1
	pula
	pulb
	cmpb #1
	beq 8f		! a conversion from 1 to 1 (skip)
	cmpb #2
	bne 4f
	pula		! a conversion from  2 to 1
	clra
	psha
	jmp 0,x
4:	pula		! a conversion from  4 to 1
	pulb
	pula
	pulb
	bra 7f
Cii_2:			! a conversion from ? to 2
	pula
	pulb
	cmpb #1		! a conversion from 1 to 2
	bne 2f
	pula
	pulb
	clra
	asrb
	rolb
	sbca #0
	bra 7f
2:	cmpb #2
	beq 8f		! a conversion from 2 to 2 (skip)
	ins		! strip upper word
	ins
	pula		! get lower word
	pulb
7:	pshb		! push result
	psha
8:	jmp 0,x
