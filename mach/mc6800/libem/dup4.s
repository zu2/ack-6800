.define Dup4
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .text

! This subroutine duplicate's the top 4 bytes.

Dup4:
	tsx
	ldx 0,x
	stx TMP
        tsx
	stab 1,x
        staa 0,x
        ldab 3,x
        ldaa 2,x
        pshb
        psha
        ldab 1,x
        ldaa 0,x
	ldx TMP
	jmp 0,x
