.define BASE
.define hol0, ADDR
.define LB, LBl
.define	ARTH, RETURN
.define start

.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .end

BASE    = 240

.sect .zero
hol0:   .space 16       ! the hol0 block
ADDR: .space 4          ! used for indirect addressing
LB: .space 2            ! the localbase
LBl: .space 2           ! the second localbase (localbase-BASE)
ARTH: .space 16         ! used for arithmetic

RETURN: .space 4        ! the return area

.sect .text
!! .base 0x0100            ! where to start in the emu6800
! GENERAL PURPOSE ROUTINES

start:
	jsr	_main
	rts

.sect .data
PROGNAME:               ! for initialising the programname pointer
.asciz "program"

.sect .bss
beginbss:
