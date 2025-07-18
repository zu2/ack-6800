.define Sli2
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine shifts a signed or unsigned interger to the
! left n times.
! N is in register B.
! The returned value is in registerpair AB.


Sli2:
	tsx
	ldx 0,x
	ins
	ins
	stab <TMP+1	! shift count
	bne 1f
	pula		! zero shift, return input
	pulb
	jmp 0,x
    1:	pula
	pulb
    2:	aslb
	rola		! shift left
	dec TMP+1
	bne 2b
	jmp 0,x


