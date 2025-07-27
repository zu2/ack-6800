.define Trap
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine performs the trap instruction.

! AccB: Trap number

Trap:
	cmpb #64
	bcc 1f
    2:	jmp Dotrap
    1:	bmi 2b
	pshb
	stab <TMP
	ldab <IGNMASK+1	! get bitmask (lowbyte)
	ldaa <IGNMASK	! get bitmask (highbyte)
    2:	lsra
	rorb		! shiftright bitmask n times
	dec TMP
	bne 2b
	bitb #1
	pulb		! clear hardware_stack
	bne 3f
	jmp Dotrap
    3:	rts

Dotrap:
	stab <TRAPVAL
	ldx <ERRPROC
	bne 1f
	jmp Mtrap
1:	ldaa #RETURN
	ldab #0
	jsr Ldi		! save return area
	ldab <hol0+5
	ldaa <hol0+4
	jsr Push	! save filename pointer
	ldab <hol0+1
	ldaa <hol0
	jsr Push	! save linenumber
	ldx <ERRPROC	! address of errorhandler
	stx <ADDR	
	ldx #0
	stx <ERRPROC	! reset ERRPROC
	ldab <TRAPVAL
	ldaa #0
	jsr Push
	ldx ADDR
	jmp 0,x		! proceed with errorhandler

.sect .data
traptbl:
	.data1	0
	.data2	EARRAY
	.data1	1
	.data2	ERANGE
	.data1	2
	.data2	ESET
	.data1	3
	.data2	EIOVFL
	.data1	10
	.data2	ECONV
	.data1	16
	.data2	ESTACK
	.data1	17
	.data2	EHEAP
	.data1	19
	.data2	EODDZ
	.data1	20
	.data2	ECASE
	.data1	25
	.data2	EBADMON
	.data1	26
	.data2	EBADLIN
	.data1	27
	.data2	EBADGTO
trapend:
!
Mtrap:
	ldx #traptbl
	bra 2f
1:	inx
	inx
	inx
	cpx #trapend
	beq errorend
2:	cmpb 0,x
	bne 1b
	ldab 2,x
	ldaa 1,x
	jsr Mprint
	jmp errorend
errorend:
	ldx TRAPVAL
	jmp EXIT
