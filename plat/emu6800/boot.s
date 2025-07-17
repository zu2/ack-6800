.define BASE
.define hol0, ADDR
.define LB, LBl
.define	ARTH, RETURN
.define START
.define TMP, TMP2
.define	_exit, _abort, doexit
.define	_putchar, _getchar, _print, _cpu_counter
BASE    = 240

.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .end


.sect .zero
hol0:   .space 16       ! the hol0 block
ADDR: .space 4          ! used for indirect addressing
LB: .space 2            ! the localbase
LBl: .space 2           ! the second localbase (localbase-BASE)
ARTH: .space 16         ! used for arithmetic
RETURN: .space 4        ! the return area
TMP: .space 2
TMP2: .space 2
exitsp: .space 2

!.base 0x0100            ! where to start in the emu6800
.sect .text
! GENERAL PURPOSE ROUTINES
START:
	sts	exitsp
	lds	#0xefff
	clrb
	clra
	pshb
	psha
	pshb
	psha
	jsr     _main
	ins
	ins
	ins
	ins
_exit:
_abort:
doexit:
	lds exitsp
	staa 0xfefb
	ldab RETURN+1
	stab 0xfeff
	rts
!
!	minimal I/O routine
!
_putchar:
	tsx
	ldab	3,x
	stab	0xfefe
	rts
_getchar:
	ldab	#95		! '_'
	stab	0xfefe
	rts
_print:
	tsx
	ldab	3,x
	ldaa	2,x
	staa	0xfefc
	stab	0xfefd
	rts
_cpu_counter:
	staa	0xfefb
	rts
.sect .data
PROGNAME:               ! for initialising the programname pointer
.asciz "program"
.sect .bss
beginbss:
