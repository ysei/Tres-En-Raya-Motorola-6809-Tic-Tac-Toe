

fin         .equ    0xFF01
teclado     .equ    0xFF02
pantalla    .equ    0xFF00

            
            .globl  programa
            .globl  imprime_menu
            .globl  mostrar_instrucciones
            .globl  dos_jugadores
            .globl  un_jugador

programa:
            lds     0xFF00
            jsr     imprime_menu
            cmpb    #'3
            beq     instrucc
            cmpb    #'2
            beq     modo2jug
            cmpb    #'1
            beq     modo1jug
            ;no se compara con la opcion 4 porque en la subrutina del menu ya sale del juego
   	    bra		programa 

instrucc:
	    jsr	    mostrar_instrucciones
		bra	programa
modo2jug:
	    	jsr     dos_jugadores
		bra	programa
modo1jug:
   	    jsr	    un_jugador
		bra	programa
	
  		.area FIJA (ABS)
		.org 	0xFFFE
		.word 	programa
