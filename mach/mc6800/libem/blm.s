.define Blm, Blmnp
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine copies bytes from one place in memory to another.
! The destinationaddress is in registerpair AB and is stored
! in zeropage locations ADDR+2 and ADDR+3.
! The source address is popped from the stack and stored in
! zeropage locations ADDR and ADDR+1.
! The number of bytes is in zeropage location NBYTES
! The subroutine Blmnp is used when the source and destination
! addresses are already in zeropage.

! NBYTES:
!	number of bytes to transfer
! Stack:
! +0	return addrrss
! +2	destination address
! +4	source address

Blm:
	tsx
	ldx 0,x
	stx <TMP
	ldx 2,x
	stx <ADDR+2	! destination address
	tsx
	ldx 4,x		! source address
	ldab <NBYTES+1
	beq 1f
	inc NBYTES
    1:	ldx <ADDR
	ldaa 0,x
	inx
	stx <ADDR
	ldx <ADDR+2
	staa 0,x
	inx
	stx <ADDR+2
	decb
	bne 1b
	dec NBYTES
	bne 1b		! do it n times
	ins
	ins
	ins
	ins
	ins
	ins
	jmp 0,x

