.define Gto
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine performs the non_local goto.
! The address of the descriptor is stored in zeropage locations
! ADDR, ADDR+1.
! Since there are two stacks (hardware_stack and the real_stack),
! the stackpointer of the hard_stack is resetted by searching the
! new localbase in the real_stack while adjusting the hardware_stack.

!
! IX:	address of descripto
!
! IX+0:	new PC
! IX+2:	new SP
! IX+4:	new LB

Gto:
	stx <ADDR
!	ins		! remove __gto return address. (?)
!	ins
	ldx 4,x		! same procedure ?
	cpx <LB
	beq 2f
	stx <ARTH	! save new LB
1:	ldx <LB
	cpx <ARTH
	beq 2f
	ldx 0,x		! search next
	bra 1b
!
2:	stx <LB
	ldab <LB+1
	ldaa <LB
	subb #BASE
	sbca #0
	stab <LBl+1
	staa <LBl
!
	ldx <ADDR	! new stackpointer
	ldx 2,x
	txs
!
	ldx <ADDR
	ldx 0,x
	jmp 0,x
