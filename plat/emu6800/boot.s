.define BASE
.define hol0, ADDR
.define LB, LBl
.define	ARTH, RETURN
.define START
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

!.base 0x0100            ! where to start in the emu6800
.sect .text
! GENERAL PURPOSE ROUTINES
START:  jmp     _main

.sect .data
PROGNAME:               ! for initialising the programname pointer
.asciz "program"
.sect .bss
beginbss:
