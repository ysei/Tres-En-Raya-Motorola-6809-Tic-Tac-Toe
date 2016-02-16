            .module menujuego

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01
            .globl  imprime_menu

            .globl  imprime_cadena

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   imprime_menu                                      ;
;       Muestra el menu del juego por pantalla        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
menu:
		.ascii	"\nTRES EN RAYA MC6809\n"
		.ascii	"1) 1 Jugador\n"
		.ascii	"2) 2 Jugadores\n"
		.ascii 	"3) Instrucciones\n"
		.ascii 	"4) Salir\n"
           	.asciz  "Opcion elegida: "
espaciado:		
		.asciz	"\n\n==============================\n\n"



imprime_menu:

            pshs    a
buclemenu:
		ldx	#espaciado
		jsr	imprime_cadena
		ldx	#menu
		jsr	imprime_cadena
		ldb 	teclado			;leemos la opcion
		cmpb	#'1	
		blo	buclemenu		;si es menor volvemos a sacar el menu
		cmpb 	#'4
		bhi	buclemenu		;si es mayor volvemos a sacar el menu

            cmpb    #'4
            beq     opcion_salir        ;termina porque el usuario elige SALIR
            puls    a
            rts
			
opcion_salir:
            clra
            sta     fin ;sale del juego

