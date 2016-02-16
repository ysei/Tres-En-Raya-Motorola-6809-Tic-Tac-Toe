	.module    compruebadiagonal1

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   comprueba_diagonal1

            .globl  imprime_cadena


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   comprueba_diagonal1                      ;
;       COMPRUEBA DIAGONAL 1 PARA GANADOR    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
diagonal3fichas:	.byte	#0
contadordiagonal1:	.byte	#0
textoganador:	.asciz	"\nGanador JUGADOR con la ficha "
textoganador2:	.asciz	"\nPulsa para volver\n"
fichamirar:	.byte	#0

comprueba_diagonal1:
		pshs	a
		stb	fichamirar
		;para resetear los valores porque si no deja guardado el estado y daria ganador al iniciar la partida siguiente a la primera
		ldb	#0
		stb	diagonal3fichas
		ldb	#0
		stb	contadordiagonal1
bucle:
	ldb	contadordiagonal1
	lda	b,x
	cmpb	#12
	beq	salir
	cmpa	fichamirar
	beq	hayx
	bra	salir
hayx:
	ldb	diagonal3fichas
	incb	
	stb	diagonal3fichas
	ldb	contadordiagonal1
	addb	#4	
	stb	contadordiagonal1
	bra	bucle
hayganador:
	ldx	#textoganador
	jsr	imprime_cadena
	lda	fichamirar
	sta	pantalla
	ldx	#textoganador2
	jsr	imprime_cadena
	lda	teclado	
	puls	a
	rts
salir:
	ldb	diagonal3fichas
	cmpb	#3
	beq	hayganador
	puls	a
	rts
