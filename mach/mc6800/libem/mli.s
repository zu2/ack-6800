.define Mli2, Mlinp, Mul
.define Mlu2, Mlinp, Mlu
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
Mlu2:
	stab <ARTH+1
	staa <ARTH
	tsx
	ldx 0,x
	stx <TMP
	ins
	ins
	pula
	pulb
	bsr Mul
	tsx
	ldx <TMP
	jmp 0,x
Mul:
Mlu:
Mlinp:	
	stab <ARTH+3
	staa <ARTH+2
	clrb
	clra
    	ldx #16
1:
	aslb
	rola
	rol ARTH+1
	rol ARTH
	bcc 2f
	addb <ARTH+3
	adca <ARTH+2
2:	dex
	bne 1b
	rts
