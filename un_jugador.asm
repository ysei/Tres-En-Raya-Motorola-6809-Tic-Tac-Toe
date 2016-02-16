            .module    unjugador

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl   un_jugador

            .globl  imprime_cadena
            .globl  jugador_aleat
	.globl	comprueba_fila
	.globl	comprueba_columna
	.globl	comprueba_diagonal1
	.globl	comprueba_diagonal2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   un_jugador                               ;
;       permite jugar al modo 1 JUGADOR      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaracion de variables a guardar
;----------------------------------
ficha:      .byte	#0	;guarda la ficha elegida por el primero
otraficha:	.byte	#0	;guarda aqui la ficha que usara el segundo jugador
primerturno: .byte   0	;almacena el valor devuelto por jugador_aleat para luego ir al bucle del jugador primero
anchotabl:  .byte   0	;para calculo de posicion elegida
;ME OBLIGA A ALMACENARLA
coord:      .byte   #0
contador:	.byte #0
barran:	.asciz	"\n"
coord1:	.byte	#0	;guarda posicion elegida por usuario
coord2:	.byte	#0	;guarda posicion elegida por usuario
posic:	.byte	#0	
fichaspuestas:	.byte	#'0	;cuenta numero de fichas puestas en el tablero por si se llena

;textos de la interfaz
;---------------------
jugada11:
            .ascii  "\nTURNO JUGADOR 1\n"     ;para el jugador1
            .asciz  "Coordenada FIL: "
jugada12:
            .asciz  "\nCoordenada COL: "
jugada21:
            .ascii  "\nTURNO MAQUINA\n"
            .ascii  "Pensando coordenada FIL\n"
            .asciz  "Pensando coordenada COL\n\n"
bienvenida:
            .asciz "\n\nMODO UN JUGADOR\n"
seleccionficha:
            .ascii  "Elige ficha (escribe en MAYUSC la letra)\n"
            .ascii  "1) X\n"
            .ascii  "2) O\n"
            .asciz  "Eleccion: "
repartofichas1:
            .asciz  "\nJUGADOR=X , MAQUINA=O\n"
repartofichas2:
            .asciz  "\nJUGADOR=O , MAQUINA=X\n"
tablerovacio:
            .ascii  "\n\n"
            .ascii  "   1 2 3 \n"
            .ascii  "  -------\n"
            .ascii  "1 . . . .\n"
            .ascii  "  -------\n"
            .ascii  "2 . . . .\n"
            .ascii  "  -------\n"
            .ascii  "3 . . . .\n"
            .asciz  "  -------\n"
tablero:
            .asciz  "---------" ;9 espacios (tablero 3x3).Array para almacenar jugada.Ascii de los guiones es 45
mensajeerror:
            .asciz  "\nAun es tu turno\nFuera de rango.Vuelve a escribir\n"
lineasig:	.asciz	"\n\n"
textosinganador:	.asciz	"\nTablero completo\nNo ha habido ganador\nPulsa para volver\n"


un_jugador:
            pshs    a
            
;codigo modo un jugador
;----------------------
modojuego:
            ldx     #bienvenida
            jsr     imprime_cadena

            ldx     #seleccionficha
            jsr     imprime_cadena
            ldb     teclado         ;leemos la opcion de ficha de teclado
            stb     ficha           ;almacenamos la opcion de ficha

            cmpb    #'X             ;mostramos reparto de fichas segun eleccion
            beq     reparto1
            cmpb    #'O
            beq     reparto2
reparto1:
            ldx     #repartofichas1
            jsr     imprime_cadena
		ldb	#'X
		stb	ficha
		ldb	#'O
		stb	otraficha
            bra     continua        ;sigue con el codigo del juego
reparto2:
            ldx     #repartofichas2
            jsr     imprime_cadena
		ldb	#'O
		stb	ficha
		ldb	#'X
		stb	otraficha
            bra     continua
continua:
            ldx     #tablerovacio   ;mostramos la disposicion del tablero
            jsr     imprime_cadena

            jsr     jugador_aleat   ;pedimos que nos diga quien tiene el primer turno
            stb     primerturno     ;almacenamos quien tiene el primer turno para cuando pida al siguiente

            cmpb    #1
            beq     bucletipo1      ;si empieza el jugador 1,va a ese bucle
            jmp     bucletipo2 ;si es la maquina,al otro
	




bucletipo1: 	;bucle para la jugada del primero

		ldb	ficha	;busca tres fichas seguidas en el tablero para ganador
		ldx	#tablero
		jsr	comprueba_fila
		cmpb	#3
		lbeq	salir
		ldb	ficha
		ldx	#tablero
		jsr	comprueba_columna
		cmpb	#3
		lbeq	salir
		ldb	ficha
		ldx	#tablero
		jsr	comprueba_diagonal1
		cmpb	#3
		lbeq	salir
		ldb	ficha
		ldx	#tablero
		jsr	comprueba_diagonal2
		cmpb	#3
		lbeq	salir

		ldb	fichaspuestas	;busca si se ha llenado el tablero sin ganador
		cmpb	#'9
		lbeq	salirsinganador

            ldx     #jugada11
            jsr     imprime_cadena
            lda     teclado     ;guardamos en a coord de fila
            ldx     #jugada12
            jsr     imprime_cadena
            ldb     teclado     ;guardamos en b coord de col

	    ldx	    #lineasig
	    jsr	    imprime_cadena

            deca    ;restamos a los regist para tener posic de 0 a 8
            decb

	sta	coord1
	cmpa	#'0
	beq	ancho0
	cmpa	#'1
	beq	ancho1
	cmpa	#'2
	beq	ancho2
ancho0:
	lda	#0	;pasamos el caracter de teclado a valor inmediato en numero en coord1
	sta	anchotabl
	lda	coord1
	bra	seguir
ancho1:
	lda	#1
	sta	anchotabl
	lda	coord1
	bra	seguir
ancho2:
	lda	#2
	sta	anchotabl
	lda	coord1
	bra	seguir
seguir:
            adda    anchotabl   ;fila*anchotablero
            adda    anchotabl

	cmpb	#'0
	beq	b1
	cmpb	#'1	;lo mismo.convierte de ascii a numero y lo guarda en coord2
	beq	b2
	cmpb	#'2
	beq	b3
b1:
	ldb	#0
	stb	coord2
	bra	imprime3
b2:
	ldb	#1
	stb	coord2
	bra	imprime3
b3:
	ldb	#2
	stb	coord2
	bra	imprime3
imprime3:
        adda    coord2   ;con esto tenemos la posic (0-8) para array tablero
	sta	coord

		ldb 	#'0
		ldx	#tablero
imprime:
		lda	,x		
		beq	irbucletipo2
		bra	noir2
irbucletipo2:
		ldb	fichaspuestas	;para saber si se llena el tablero en caso de no haber ganador
		incb			;lo incrementamos cada vez que se ponga una y pase a la jugada del siguiente
		stb	fichaspuestas
		lbra	bucletipo2
noir2:
		cmpb	#'3
		beq	saltolineasig	;imprime un salto cada 3 huecos para fichas para poner tablero 3x3
		cmpb	#'6
		beq	saltolineasig
		cmpb	#'9
		beq	saltolineasig
		bra	continue
saltolineasig:
		tfr	x,y
		ldx	#barran	;imprime saltos de linea cada 3 huecos de tablero
		jsr	imprime_cadena
		tfr	y,x
		cmpb	coord
		beq	meterficha
continue:
		cmpb	coord
		beq	meterficha	
		sta	pantalla
		incb	
		lda	,x+
		bra	imprime
meterficha:
		stb	contador
		ldb	ficha
		cmpa	#45		;si hay algo muestra error.si no la mete en ese hueco.45 es el guion en ascii
		lbhi	muestraerror
		stb	,x	;si no lo hay,la pone ahi y sigue mostrando el tablero ahora con la ficha
		lda	,x+
		sta	pantalla
		ldb 	contador
		incb
		bra	imprime




bucletipo2:	;bucle para la jugada del segundo

		ldb	otraficha	;busca ganador en el tablero.las funciones devuelven 3 si lo hay
		ldx	#tablero
		jsr	comprueba_fila
		cmpb	#3
		lbeq	salir
		ldb	otraficha
		ldx	#tablero
		jsr	comprueba_columna
		cmpb	#3
		lbeq	salir
		ldb	otraficha
		ldx	#tablero
		jsr	comprueba_diagonal1
		cmpb	#3
		lbeq	salir
		ldb	otraficha
		ldx	#tablero
		jsr	comprueba_diagonal2
		cmpb	#3
		lbeq	salir
		
		ldb	fichaspuestas	;comprueba si se llena el tablero sin ganador
		cmpb	#'9
		lbeq	salirsinganador

            ldx     #jugada21
            jsr     imprime_cadena

            ldb     #'0  ;las cargamos con 1(en el vector el numero 0) y va viendo donde cabe su ficha
	    ldx	    #tablero
bucletipo22:
            lda     ,x
	    lbeq    irbucletipo1
		bra	noir
irbucletipo1:
		ldb	fichaspuestas
		incb	
		stb	fichaspuestas
		lbra	bucletipo1
noir:
		cmpb	#'3	;cada 3 huecos muestra salto de linea para hacer tablero 3x3
		beq	saltolineasig1
		cmpb	#'6
		beq	saltolineasig1
		cmpb	#'9
		beq	saltolineasig1
		bra	sigue1
saltolineasig1:
		tfr	x,y
		ldx	#barran
		jsr	imprime_cadena
		tfr	y,x
sigue1:
	    cmpa    #45
	    bhi	    bucletipo23	;si esta ocupado pasa a ese bucle para probar otro hueco.45 el ascii de los guiones del tablero

	    stb	    posic
            ldb     otraficha
            stb     ,x	;si no hay nada lo pone ahi y sigue mostrando el tablero actualizado con la ficha
	    lda	    ,x+
	    ldb	    posic
	    sta     pantalla
	    incb
	    bra	    fichapuesta
bucletipo23:
	    sta	    pantalla
            incb  	;probamos con la siguiente posicion si ya hay algo
	    lda	    ,x+
            bra     bucletipo22
fichapuesta:
	    lda	    ,x
	    lbeq    irbucletipo1

		cmpb	#'3
		beq	saltolineasig11
		cmpb	#'6
		beq	saltolineasig11
		cmpb	#'9
		beq	saltolineasig11
		bra	sigue11
saltolineasig11:
		tfr	x,y
		ldx	#barran
		jsr	imprime_cadena
		tfr	y,x
sigue11:

	    sta     pantalla
	    lda	    ,x+
	    incb
	    bra	    fichapuesta

muestraerror:
	    ldb	    contador
muestraerror2:
	    	lda	,x
		beq	sigueerror
	
		cmpb	#'3
		beq	saltolineasig111
		cmpb	#'6
		beq	saltolineasig111
		cmpb	#'9
		beq	saltolineasig111
muestraerror3:
		sta	pantalla	;muestra el tablero para que se vean posibles huecos al no valer la elegida antes
		incb	
		lda	,x+
		bra	muestraerror2
saltolineasig111:
		tfr	x,y
		ldx	#barran
		jsr	imprime_cadena
		tfr	y,x
		bra	muestraerror3
sigueerror:
            ldx     #mensajeerror
            jsr     imprime_cadena
            lbra     bucletipo1    



salir:
		ldx	#tablero
		bra	resetea
salirsinganador:
		ldx	#textosinganador	;si se llena el tablero y no hay ganador lo pone en pantalla y sale
		jsr	imprime_cadena
		ldx	#tablero
resetea:
		lda	,x	;reseteamos el tablero para poder jugar de nuevo
		beq	salfinal	;una vez lo ponga a 0 del todo salimos
		ldb	#'-
		stb	,x
		lda	,x+
		bra	resetea
salfinal:
		ldb	#0
		stb	fichaspuestas	;pone a 0 el contador de fichas puestas por si se juega de nuevo
		puls	a
		rts














