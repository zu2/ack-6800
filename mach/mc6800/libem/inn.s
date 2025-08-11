.define Inn
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine checks if a certain bit is set in a set
! of n bytes on top of the stack.

! AccAB: size of set (bytes)
! Stack:
! +0,+1: return address
! +2,+3: bit number
! +4...: data

Inn:
	tsx
	ldx 0,x
	stx <TMP
	ins
	ins
!
	stab <ARTH+1	! save data size
	staa <ARTH
!
	tsx
	inx
	inx
	stx <ADRS	! save top of data address
	addb <ADRS+1
	adca <ADRS
	stab <ADRS+3	! save end of data address
	staa <ADRS+2
!
	pula		! get bit number
	pulb
!
	stab <ARTH+3	! save bit number
	staa <ARTH+2
!
	bmi 7f		! bit number < 0
!
	asra		! bit/8
	rorb
	asra
	rorb
	asra
	rorb
!
	pshb
	psha
	subb <ARTH+1	! check in range
	sbca <ARTH
	bpl	7f	! (bit number/8)>=size
!
	pula
	pulb
	addb <ADRS+1	! calcucalte data address
	adca <ADRS
	stab <ADRS+1
	staa <ADRS
	ldx <ADRS
!
	ldaa #1		! bit pos
	ldab <ARTH+3	! get bit number
	andb #7		! bit number % 8
	beq 2f
1:
	asla
	decb
	bne 1b
2:
!			! here, AccB==0
	anda 0,x	! bit(i,s)
	beq 9f
	incb
	bra 8f
!
7:	clrb
8:	clra
9:	ldx <ADRS+2	! adjust stack
	txs
	ldx <TMP
	jmp 0,x
