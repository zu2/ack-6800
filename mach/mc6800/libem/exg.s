.define Exg
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine exchanges two groups of bytes on the top of the
! stack. The groups may consist of atmost 255 bytes.
! This number is in register Y.
! The exchange is from ADDR, ADDR+1 to ADDR+2, ADDR+3

! AccAB: n (bytes)
! Stack:
! +0,+1:     return address
! +2,+n+1:   first group
! +n+2,+2n+1:second group

Exg:
	tsx
	ldx 0,x
	stx <TMP
	ins
	ins
	tsx
	stx <ADRS
!
	stab <ARTH+1
	staa <ARTH
	addb <ADRS+1	! calculate second group's address
	adca <ADRS
	stab <ADRS+3
	staa <ADRS+2
!
	ldab <ARTH+1	! adjust size for loop
	beq 1f
	inc ARTH
1:
!	ldx <ADRS
	dex
2:
	inx
	ldab 0,x
	stx <ADRS
	ldx <ADRS+2
	ldaa 0,x
	stab 0,x
	inx
	stx <ADRS+2
	ldx <ADRS
	staa 0,x
	dec ARTH+1
	bne 2b
	dec ARTH
	bne 2b
!
	ldx <TMP
	jmp 0,x
