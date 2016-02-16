            .module instrucciones

pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01
            .globl  mostrar_instrucciones

            .globl  imprime_cadena
            .globl  imprime_menu


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   mostrar_instrucciones                               ;
;       Muestra las instrucciones del juego por pantalla;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instrucciones:
			.ascii	"\n-Instrucciones del juego:-\n\n"
			.ascii	"El juego dispone de 2 modos: 1 jugador y 2 jugadores.\nUsted lo tendra que elegir en el menu del juego.\n"
			.ascii	"Se trata de conseguir una linea de tres con tu ficha (vert,horiz,diag)\n que se elegira al comienzo de la partida\n"
			.ascii 	"En el modo 1 jugador la maquina compite contra usted.\nEn el de 2 jugadores lo puede hacer con un amigo\n"
			.asciz 	"\n-Pulse una tecla para volver al menu-\n"

espaciado:		.asciz	"\n\n==============================\n\n"




mostrar_instrucciones:

            pshs    a
buclemenu:
			ldx	#espaciado
			jsr	imprime_cadena
			ldx	#instrucciones
			jsr	imprime_cadena
			ldb 	teclado			;leemos la opcion
			puls	a
			rts
			
