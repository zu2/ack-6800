.define Csa,CsaX
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine performs the case jump by searching the table.
! The zeropage locations ADDR, ADDR+1 contain the address of the
! case descriptor, which also is the address of the default pointer.

!
! case_table: <- (AccAB)
! default_addr: .data2 adrs
! +2 lower bound:  .data2 num1
! +4 upper bound:	.data2 num2
! +6 jump_addr:	.data2 adrs	/* case num1: */
! +8 jump_addr:	.data2 adrs	/* case num1+1: */
!

! TOS: switch value

Csa:
	stab <ADDR+1	! address of descriptor (lowbyte)
	staa <ADDR	! address of descriptor (highbyte)
	ldx <ADDR
CsaX:	stx <ADDR
	pula
	pulb
	stab ARTH+3	! save switch value
	staa ARTH+2
	subb 3,x	! lower bound case
	sbca 2,x
	blt 9f		! value < lower
	stab ARTH+1	! save value-lower
	staa ARTH
	ldab ARTH+3	! restore switch value
	ldaa ARTH+2
	subb 5,x	! upper bound case
	sbca 4,x
	bgt 9f		! value > upper bound
! jump table
	ldab ARTH+1
	ldaa ARTH
	aslb
	rola
	addb ADDR+1
	adca ADDR
	addb #6		! skip to jump table
	adca #0
	stab ADDR+1
	staa ADDR
	ldx ADDR
! default
9:
	ldx 0,x
	jmp 0,x
