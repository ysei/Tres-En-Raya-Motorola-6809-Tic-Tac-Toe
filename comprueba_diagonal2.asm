	.module    compruebadiagonal2

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   comprueba_diagonal2

            .globl  imprime_cadena


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   comprueba_diagonal2                      ;
;       COMPRUEBA LA DIAGONAL 2 PARA GANADOR ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
diagonal3fichas:	.byte	#0
contadordiagonal2:	.byte	#6
textoganador:	.asciz	"\nGanador JUGADOR con la ficha	"
textoganador2:	.asciz	"\nPulsa para volver\n"
fichamirar:	.byte	#0

comprueba_diagonal2:
		pshs	a
		stb	fichamirar
		;resetear los valores si sigue jugando porque si no se quedan guardados y mostraria que hay ganador al empezar otra
		ldb	#0	
		stb	diagonal3fichas
		ldb	#0
		stb	contadordiagonal2
bucle:
	ldb	contadordiagonal2
	lda	b,x
	cmpb	#0
	beq	salir
	cmpa	fichamirar
	beq	hayx
	bra	salir
hayx:
	ldb	diagonal3fichas
	incb	
	stb	diagonal3fichas
	ldb	contadordiagonal2
	subb	#2	
	stb	contadordiagonal2
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
