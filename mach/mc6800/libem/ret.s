.define Ret0
.define Ret1
.define Ret2
.define Ret4

.sect .zero
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .end

.sect .text
Ret1:
	stab	<RETURN
	bra	1f
Ret2:
	pula
	pulb
	stab	<RETURN+1
	staa	<RETURN
	bra	1f
Ret4:
	pula
	pulb
	stab	<RETURN+1
	staa	<RETURN
	pula
	pulb
	stab	<RETURN+3
	staa	<RETURN+2
1:
Ret0:
	ldx	<LB
	txs
	pula
	pulb
	stab	<LB+1
	staa	<LB
	subb	#BASE
	sbca	#0
	stab	<LBl+1
	staa	<LBl
	rts
