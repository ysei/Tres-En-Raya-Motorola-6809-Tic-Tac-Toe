.module    dosjugadores

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   dos_jugadores

            .globl  imprime_cadena
            .globl  jugador_aleat
	.globl	comprueba_fila
	.globl	comprueba_columna
	.globl	comprueba_diagonal1
	.globl	comprueba_diagonal2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   dos_jugadores                            ;
;       permite jugar al modo 1 JUGADOR      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaracion de variables a guardar
;----------------------------------
dficha:      .byte	#0
dprimerturno: .byte   0
;direccion:  .word
danchotabl:  .byte   0
daspas:      .byte  #'X
dcirculos:   .byte  #'O
;ME OBLIGA A ALMACENARLA
dcoord:      .byte   #0
dcontador:	.byte #0
dbarran:	.asciz	"\n"
dcoord1:	.byte	#0
dcoord2:	.byte	#0
dfichaspuestas:	.byte	#'0
dotraficha:	.byte	#0	

;textos de la interfaz
;---------------------
dbienvenida:
            .asciz "\n\nMODO DOS JUGADORES\n"
dseleccionficha:
            .ascii  "\nElige ficha\n"
            .ascii  "1) X\n"
            .ascii  "2) O\n"
            .asciz  "Eleccion: "
dtexto2jugador:
		.ascii	"\nTURNO SEGUNDO JUGADOR\n\0"
dtexto2jugador2:	
		.ascii	"Coordenada FILA: \0"
dtexto2jugador22:
		.ascii	"\nCoordenada COLUMMA: \0"
djugadaprimero:
		.ascii 	"\nTURNO JUGADOR 1\n"
		.asciz	"Coordenada FIL: "
djugada12:
            .asciz  "\nCoordenada COL: "
drepartofichas1:
            .asciz  "\nJUGADOR 1=X , JUGADOR 2=O\n"
drepartofichas2:
            .asciz  "\nJUGADOR 1=O , JUGADOR 2=X\n"
dtablerovacio:
            .ascii  "\n\n"
            .ascii  "   1 2 3 \n"
            .ascii  "  -------\n"
            .ascii  "1 . . . .\n"
            .ascii  "  -------\n"
            .ascii  "2 . . . .\n"
            .ascii  "  -------\n"
            .ascii  "3 . . . .\n"
            .asciz  "  -------\n"
dtablero:
            .asciz  "---------" ;9 espacios (tablero 3x3).Array para almacenar jugada.45 es el guion en ascii
dmensajeerror:
            .asciz  "\nAun es tu turno\nFuera de rango.Vuelve a escribir\n"
dlineasig:	.asciz	"\n\n"
dtextosinganador:	.asciz	"\nTablero completo\nNo ha habido ganador\nPulsa para volver\n"





dos_jugadores:
            pshs    a

;codigo modo dos jugadores
;-------------------------
dmodojuego:
            ldx     #dbienvenida
            jsr     imprime_cadena

            ldx     #dseleccionficha
            jsr     imprime_cadena
            ldb     teclado         ;leemos la opcion de ficha de teclado
            stb     dficha           ;almacenamos la opcion de ficha

            cmpb    #'X             ;mostramos reparto de fichas segun eleccion
            beq     dreparto1
            cmpb    #'O
            beq     dreparto2
dreparto1:
            ldx     #drepartofichas1
            jsr     imprime_cadena
		ldb	#'X
		stb	dficha
		ldb	#'O
		stb	dotraficha
            bra     dcontinua        ;sigue con el codigo del juego
dreparto2:
            ldx     #drepartofichas2
            jsr     imprime_cadena
		ldb	#'O
		stb	dficha
		ldb	#'X
		stb	dotraficha
            bra     dcontinua
dcontinua:
            ldx     #dtablerovacio   ;mostramos la disposicion del tablero
            jsr     imprime_cadena

            jsr     jugador_aleat   ;pedimos que nos diga quien tiene el primer turno
            stb     dprimerturno     ;almacenamos quien tiene el primer turno para cuando pida al siguiente

            cmpb    #1
            beq     dbucletipo1      ;si empieza el jugador 1,va a ese bucle
		lbra	dbucletipo2



dbucletipo1: 
		ldb	dficha	;busca un ganador en el tablero.devuelven el valor 3 si lo hay terminando la partida
		ldx	#dtablero
		jsr	comprueba_fila
		cmpb	#3
		lbeq	salir
		ldb	dficha
		ldx	#dtablero
		jsr	comprueba_columna
		cmpb	#3
		lbeq	salir
		ldb	dficha
		ldx	#dtablero
		jsr	comprueba_diagonal1
		cmpb	#3
		lbeq	salir
		ldb	dficha
		ldx	#dtablero
		jsr	comprueba_diagonal2
		cmpb	#3
		lbeq	salir

		ldb	dfichaspuestas	;comprueba si se llena el tablero sin ganador
		cmpb	#'9
		lbeq	dsalirsinganador


		ldx	#djugadaprimero
		jsr	imprime_cadena
		lda	teclado	;guardamos en a coord de fila
            ldx     #djugada12
            jsr     imprime_cadena
            ldb     teclado     ;guardamos en b coord de columna

   	    ldx	    #dlineasig
	    jsr	    imprime_cadena

            deca    ;restamos a los regist para tener posic de 0 a 8
            decb

	   	sta	dcoord1
	cmpa	#'0
	beq	dancho0
	cmpa	#'1
	beq	dancho1
	cmpa	#'2
	beq	dancho2
dancho0:
	lda	#0	;pasamos del numero tecleado en ascii al numero en si y lo guardamos
	sta	danchotabl
	lda	dcoord1
	bra	dseguir
dancho1:
	lda	#1
	sta	danchotabl
	lda	dcoord1
	bra	dseguir
dancho2:
	lda	#2
	sta	danchotabl
	lda	dcoord1
	bra	dseguir

dseguir:
            adda    danchotabl   ;fila*anchotablero
            adda    danchotabl

	cmpb	#'0
	beq	db1
	cmpb	#'1
	beq	db2
	cmpb	#'2
	beq	db3
db1:
	ldb	#0
	stb	dcoord2
	bra	dimprime3
db2:
	ldb	#1
	stb	dcoord2
	bra	dimprime3
db3:
	ldb	#2
	stb	dcoord2
	bra	dimprime3

dimprime3:
        adda    dcoord2   ;con esto tenemos la posic (0-8) para array tablero
	sta	dcoord
	
		ldb 	#'0
		ldx	#dtablero
dimprime:
		lda	,x		
		beq	dirbucletipo2
		bra	dnoir2
dirbucletipo2:
		ldb	dfichaspuestas	;incrementa el contador de fichas puestas cuando va a la siguiente jugada
		incb	
		stb	dfichaspuestas
		lbra	dbucletipo2
dnoir2:
		cmpb	#'3	;imprime salto de linea cada 3 huecos de tablero
		beq	dsaltolineasig
		cmpb	#'6
		beq	dsaltolineasig
		cmpb	#'9
		beq	dsaltolineasig
		bra	dcontinue
dsaltolineasig:
		tfr	x,y
		ldx	#dbarran
		jsr	imprime_cadena
		tfr	y,x
		cmpb	dcoord
		beq	dmeterficha
dcontinue:
		cmpb	dcoord
		beq	dmeterficha
		sta	pantalla
		incb	
		lda	,x+
		bra	dimprime
dmeterficha:
		stb	dcontador
		ldb	dficha
		cmpa	#45	;si ya hay algo muestra que debe probarse otra posicion.45 es el codigo de los guiones del tablero
		bhi	dmuestraerror
		stb	,x	;si no hay nada pone la ficha ahi y sigue mostrando el tablero ya con la ficha
		lda	,x+
		sta	pantalla
		ldb 	dcontador
		incb
		bra	dimprime
dmuestraerror:
	    ldb	    dcontador
dmuestraerror2:
	    	lda	,x
		lbeq	dsigueerror
	
		cmpb	#'3
		beq	dsaltolineasig111
		cmpb	#'6
		beq	dsaltolineasig111
		cmpb	#'9
		beq	dsaltolineasig111
dmuestraerror3:
		sta	pantalla	;sigue mostrando el tablero para pensar otra posible posicion ya que la anterior no valia
		incb	
		lda	,x+
		bra	dmuestraerror2
dsaltolineasig111:
		tfr	x,y	;muestra salto de linea cada 3 huecos de tablero para mostrar uno 3x3
		ldx	#dbarran
		jsr	imprime_cadena
		tfr	y,x
		bra	dmuestraerror3
dsigueerror:
            ldx     #dmensajeerror
            jsr     imprime_cadena
            lbra     dbucletipo1    




 

dbucletipo2: 		
		ldb	dotraficha
		ldx	#dtablero	;comprueba el tablero en busca de un ganador
		jsr	comprueba_fila
		cmpb	#3
		lbeq	salir
		ldb	dotraficha
		ldx	#dtablero
		jsr	comprueba_columna
		cmpb	#3
		lbeq	salir
		ldb	dotraficha
		ldx	#dtablero
		jsr	comprueba_diagonal1
		cmpb	#3
		lbeq	salir
		ldb	dotraficha
		ldx	#dtablero
		jsr	comprueba_diagonal2
		cmpb	#3
		lbeq	salir
		
		ldb	dfichaspuestas	;comprueba si se llena el tablero sin ganador para terminar en ese caso
		cmpb	#'9
		lbeq	dsalirsinganador

            ldx     #dtexto2jugador
            jsr     imprime_cadena
            ldx     #dtexto2jugador2
            jsr     imprime_cadena
            lda     teclado     ;guardamos en a coord de fila
		ldx	#dtexto2jugador22
		jsr	imprime_cadena
		ldb	teclado	;guardamos en b coord de columna

   	    ldx	    #dlineasig
	    jsr	    imprime_cadena

            deca    ;restamos a los regist para tener posic de 0 a 8
            decb

	sta	dcoord1
	cmpa	#'0	;pasamos el ascii del teclado a valor inmediato
	lbeq	dancho02
	cmpa	#'1
	lbeq	dancho12
	cmpa	#'2
	lbeq	dancho22
dancho02:
	lda	#0
	sta	danchotabl
	lda	dcoord1
	bra	dseguir2
dancho12:
	lda	#1
	sta	danchotabl
	lda	dcoord1
	bra	dseguir2
dancho22:
	lda	#2
	sta	danchotabl
	lda	dcoord1
	bra	dseguir2

dseguir2:
            adda    danchotabl   ;fila*anchotablero
            adda    danchotabl

	cmpb	#'0
	beq	db12
	cmpb	#'1
	beq	db22
	cmpb	#'2
	beq	db32
db12:
	ldb	#0	;pasamos el ascii del numero de teclado a valor inmediato
	stb	dcoord2
	bra	dimprime32
db22:
	ldb	#1
	stb	dcoord2
	bra	dimprime32
db32:
	ldb	#2
	stb	dcoord2
	bra	dimprime32

dimprime32:
        adda    dcoord2   ;con esto tenemos la posic (0-8) para array tablero
	sta	dcoord
	
		ldb 	#'0
		ldx	#dtablero
dimprime2:
		lda	,x		
		beq	dsaltabucle1
		bra	dsigueimprimiendo
dsaltabucle1:
		ldb	dfichaspuestas	;incrementa el contador cada vez que se ha puesto una ficha y va a pasar a otra jugada
		incb	
		stb	dfichaspuestas
		jmp	dbucletipo1
dsigueimprimiendo:
		cmpb	#'3	;imprime salto de linea cada 3 huecos para tablero 3x3
		beq	dsaltolineasig1
		cmpb	#'6
		beq	dsaltolineasig1
		cmpb	#'9
		beq	dsaltolineasig1
		bra	dcontinue11
dsaltolineasig1:
		tfr	x,y
		ldx	#dbarran
		jsr	imprime_cadena
		tfr	y,x
		cmpb	dcoord
		beq	dmeterficha2
dcontinue11:
		cmpb	dcoord
		beq	dmeterficha2
		sta	pantalla
		incb	
		lda	,x+
		bra	dimprime2
dmeterficha2:
		stb	dcontador
		ldb	dotraficha
		cmpa	#45
		bhi	dmuestraerror1	;si hay algo en la posicion lo muestra para que se piense otra
		stb	,x	;si no hay nada pone la ficha ahi y sigue mostrando por pantalla el tablero actualizado
		lda	,x+
		sta	pantalla
		ldb 	dcontador
		incb
		bra	dimprime2
dmuestraerror1:	
		ldb	dcontador
dmuestraerror11:
		lda	,x
		beq	dsigueerror2
		cmpb	#'3	
		beq	dsaltolineasig222
		cmpb	#'6
		beq	dsaltolineasig222
		cmpb	#'9
		beq	dsaltolineasig222
dmuestraerror33:
		sta	pantalla	;muestra el tablero para que se vea como esta y se piense otro sitio donde ponerla
		incb	
		lda	,x+
		bra	dmuestraerror11
dsaltolineasig222:
		tfr	x,y
		ldx	#dbarran
		jsr	imprime_cadena
		tfr	y,x
		bra	dmuestraerror33
dsigueerror2:
            ldx     #dmensajeerror
            jsr     imprime_cadena
            lbra     dbucletipo2    


salir:		
		ldx	#dtablero
		bra	resetea
dsalirsinganador:
		ldx	#dtextosinganador
		jsr	imprime_cadena
		lda	teclado
		ldx	#dtablero
resetea:
		lda	,x	;pone a 0 el tablero para poder jugar de nuevo
		beq	dsalfinal
		ldb	#'-
		stb	,x
		lda	,x+
		bra	resetea
dsalfinal:
		ldb	#'0
		stb	dfichaspuestas	;reseteamos el contador de las fichas puestas por si se vuelve a jugar
		puls	a
		rts
