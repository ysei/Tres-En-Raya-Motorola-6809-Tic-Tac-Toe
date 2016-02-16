	.module    compruebafila

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   comprueba_fila

            .globl  imprime_cadena


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   comprueba_fila1                          ;
;       COMPRUEBA FILAS  PARA GANADOR        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fila3fichas:	.byte	#0
contadorfila:	.byte	#0
textoganador:	.asciz	"\nGanador JUGADOR con la ficha "
textoganador2:	.asciz	"\nPulsa para volver\n"
fichamirar:	.byte	#0

comprueba_fila:
		pshs	a
		stb	fichamirar
		;para resetear los valores porque si no deja guardado el estado y daria ganador al iniciar la partida siguiente a la primera
		ldb	#0
		stb	fila3fichas
		ldb	#0
		stb	contadorfila
buclefila1:
	ldb	contadorfila
	lda	b,x
	cmpb	#3
	beq	salir1
	cmpa	fichamirar	
	beq	hayxfila1	;si hay en el primer hueco sigue mirando
	bra	salir1	;si no hay en el primero hueco de la fila mira la segunda
hayxfila1:
	ldb	fila3fichas
	incb	
	stb	fila3fichas	;aumenta el contador de fichas seguidas
	ldb	contadorfila
	incb	
	stb	contadorfila
	bra	buclefila1

hayganador:	;si hay combinacion de 3 en alguna fila muestra que hay ganador
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
	ldb	fila3fichas
	cmpb	#3
	beq	hayganador
	ldb	#3	;si no hay 3 seguidas,pasamos a la segunda fila (elemento 3 empezando por 0)
	stb	contadorfila
	ldb	#0	;ponemos a 0 contador de fichas seguidas encontradas
	stb	fila3fichas
	bra	buclefila2	;vamos al bucle para mirar la segunda fila

buclefila2:
	ldb	contadorfila
	lda	b,x
	cmpb	#6	;hasta el ultimo elemento de la fila 2 
	beq	salir2
	cmpa	fichamirar
	beq	hayxfila2
	bra	salir2
hayxfila2:
	ldb	fila3fichas
	incb	
	stb	fila3fichas
	ldb	contadorfila
	incb	
	stb	contadorfila
	bra	buclefila2
salir2:
	ldb	fila3fichas
	cmpb	#3
	beq	hayganador
	ldb	#6	;cargamos la primera posicion de la tercera fila
	stb	contadorfila
	ldb	#0	;ponemos a 0 el contador de fichas encontradas y vamos al bucle para mirar la fila 3
	stb	fila3fichas
	bra	buclefila3
buclefila3:
	ldb	contadorfila
	lda	b,x
	cmpb	#9	;hasta el ultimo elemento de la tercera fila 
	beq	salir3
	cmpa	fichamirar
	beq	hayxfila3
	bra	salir3
hayxfila3:
	ldb	fila3fichas
	incb	
	stb	fila3fichas
	ldb	contadorfila
	incb	
	stb	contadorfila
	bra	buclefila3
salir3:
	ldb	fila3fichas
	cmpb	#3
	lbeq	hayganador
	puls	a	;sale si no hay ganador
	rts

	
	

	
