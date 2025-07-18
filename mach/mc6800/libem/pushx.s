.define Pushx
.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss

.sect .text

Pushx:
	stx <TMP
	tsx
	ldx 0,x
	ins
	ins
	ldab <TMP+1
	ldaa <TMP
	pshb
	psha
    	jmp 0,x
