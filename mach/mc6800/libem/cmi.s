.define Cmi
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine compares on two integers.
! If T is pushed first and than S, the routine will return:
!   -1  if S < T,
!    0  if S = T,
!    1  if S > T.


Cmi:
	tsx
	ldx 0,x
	ins
	ins
	stab ARTH+1	! save second operand (highbyte)
	staa ARTH	! save second operand (lowbyte)
	pula
	pulb
	subb ARTH+1	! subtract second operand (lowbyte)
	sbca ARTH	! subtract second operand (highbyte)
	bpl 1f		! S >= T
	ldab #0x0FF	! S < T
	tba		! AX becomes -1
	jmp 0,x
    1:	beq 2f
    3:	ldab #1		! S > T
	clra		! AX becomes 1
	jmp 0,x
    2:	tstb
	bne 3b
	jmp 0,x



