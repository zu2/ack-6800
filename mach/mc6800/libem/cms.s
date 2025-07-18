.define Cms
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine compares two groups of bytes, bit for bit.
! The groups can consist of 2 or 4 bytes. This number is in
! register AccB.
! The address of the first group is stored in zeropage locations
! ADDR and ADDR+1, the address of the second group in ADDR+2 and ADDR+3
! The routine returns a 0 on equality, a 1 otherwise.



Cms:
	clra
	tsx
	ldx 0,x		! get return address
	ins
	ins
	stx <TMP
	tsx
	subb #2
	bne Cms_4	! 4byte compare
!
	ldx 0,x		! get first group
	stx <ARTH
	tsx
	ldx 2,x		! get second group
	ins
	ins
	ins
	ins
!
	cpx <ARTH
	beq 0f
1:
	incb
0:
	ldx <TMP
	jmp 0,x
!
Cms_4:
	clrb
	ldx 0,x		! get first group
	stx <ARTH
	tsx
	ldx 2,x
	stx <ARTH+2
	ins
	ins
	ins
	ins
	tsx
	ldx 0,x		! get second group
	stx <ARTH+4
	tsx
	ldx 2,x
	ins
	ins
	ins
	ins
!	stx <ARTH+6
!
	cpx <ARTH+2
	bne 1b
	ldx <ARTH+4
	cpx <ARTH
	bne 1b
	bra 0b
