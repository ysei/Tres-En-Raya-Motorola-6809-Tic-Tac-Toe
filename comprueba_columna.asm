	.module    compruebacolumna

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   comprueba_columna

            .globl  imprime_cadena


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   comprueba_columna1                       ;
;       COMPRUEBA COLUMNA   PARA GANADOR     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
columna3fichas:	.byte	#0
contadorcolumna:	.byte	#0
textoganador:	.asciz	"\nGanador JUGADOR con la ficha "
textoganador2:	.asciz	"\nPulsa para volver\n"
fichamirar:	.byte	#0

comprueba_columna:
		pshs	a
		stb	fichamirar
		;para resetear los valores porque si no deja guardado el estado y daria ganador al iniciar la partida siguiente a la primera
		ldb	#0
		stb	columna3fichas
		ldb	#0
		stb	contadorcolumna
buclecolumna1:
	ldb	contadorcolumna
	lda	b,x
	cmpb	#9
	beq	salir1
	cmpa	fichamirar	
	beq	hayxcolumna1	;si hay en el primer hueco sigue mirando
	bra	salir1	;si no hay en el primero hueco de la columna mira la segunda
hayxcolumna1:
	ldb	columna3fichas
	incb	
	stb	columna3fichas	;aumenta el contador de fichas seguidas
	ldb	contadorcolumna
	addb	#3		;incrementa de 3 en 3 para pasar al elemento debajo suyo
	stb	contadorcolumna
	bra	buclecolumna1

hayganador:	;si hay combinacion de 3 en alguna columna muestra que hay ganador
	ldx	#textoganador
	jsr	imprime_cadena
	lda	fichamirar
	sta	pantalla
	ldx	#textoganador2
	jsr	imprime_cadena
	lda	teclado	
	puls	a
	rts
salir1:
	ldb	columna3fichas
	cmpb	#3
	beq	hayganador
	ldb	#1	;si no hay 3 seguidas,pasamos a la segunda columna (elemento 2 empezando por 0)
	stb	contadorcolumna
	ldb	#0	;ponemos a 0 contador de fichas seguidas encontradas
	stb	columna3fichas
	bra	buclecolumna2	;vamos al bucle para mirar la segunda columna

buclecolumna2:
	ldb	contadorcolumna
	lda	b,x
	cmpb	#10	;hasta el ultimo elemento de la columna 2 
	beq	salir2
	cmpa	fichamirar
	beq	hayxcolumna2
	bra	salir2
hayxcolumna2:
	ldb	columna3fichas
	incb	
	stb	columna3fichas
	ldb	contadorcolumna
	addb	#3	
	stb	contadorcolumna
	bra	buclecolumna2
salir2:
	ldb	columna3fichas
	cmpb	#3
	beq	hayganador
	ldb	#2	;cargamos la primera posicion de la tercera columna
	stb	contadorcolumna
	ldb	#0	;ponemos a 0 el contador de fichas encontradas y vamos al bucle para mirar la columna 3
	stb	columna3fichas
	bra	buclecolumna3
buclecolumna3:
	ldb	contadorcolumna
	lda	b,x
	cmpb	#11	;hasta el ultimo elemento de la tercera columna 
	beq	salir3
	cmpa	fichamirar
	beq	hayxcolumna3
	bra	salir3
hayxcolumna3:
	ldb	columna3fichas
	incb	
	stb	columna3fichas
	ldb	contadorcolumna
	addb	#3	
	stb	contadorcolumna
	bra	buclecolumna3
salir3:
	ldb	columna3fichas
	cmpb	#3
	lbeq	hayganador
	puls	a	;sale si no hay ganador
	rts
