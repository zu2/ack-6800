.define Mli2, Mlinp, Mul
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss

! The subroutine Mli2 multiplies two signed integers. The integers
! are popped from the stack.
! The subroutine Mlinp expects the two integer to be in zeropage.
! While the subroutine Mul an unsigned multiply subroutine is.

.sect .text
Mli2:
	stab ARTH+1
	staa ARTH
	pula
	pulb
	stab ARTH+3
	staa ARTH+2
Mlinp:	
Mul:
	clrb
	clra
    	ldx #16
1:
	aslb
	rola
	rol ARTH+1
	rol ARTH
	bcc 2f
	addb ARTH+3
	adca ARTH+2
2:	dex
	bne 1b
	rts
