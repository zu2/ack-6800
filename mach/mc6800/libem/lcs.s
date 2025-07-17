.define Lcs
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine creates space for locals on procedure entry
! by lowering the stackpointer.

Lcs:
	tsx
	ldx 0,x
	ins
	ins
	stab ARTH+1	! number of locals (lowbyte)
	staa ARTH	! number of locals (highbyte)
	sts TMP
	ldab TMP+1
	ldaa TMP
	subb ARTH+1
	sbca ARTH
	stab TMP+1
	staa TMP
	lds TMP
	jmp 0,x


