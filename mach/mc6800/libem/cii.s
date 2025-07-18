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
	cmpb #2
	beq Cii_2	! a conversion from ? to 2
	pula		! a conversion from ? to 4
	pulb
	cmpb #4
	beq 8f		! a conversion 4 to 4 (skip)
	pula		! check sign bit
	psha
	clrb
	asla
	sbcb #0		! sign extend
	pshb
	pshb
    8:	jmp 0,x
Cii_2:			! a conversion from ? to 2
	pula
	pulb
	cmpb #2
	beq 8f		! a conversion from 2 to 2 (skip)
	pula		! get lower word
	pulb
	ins		! strip upper word
	ins
	pshb		! push result
	psha
    8:	jmp 0,x
