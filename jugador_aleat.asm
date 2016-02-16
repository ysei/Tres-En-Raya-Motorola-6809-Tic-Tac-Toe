            .module aleatorio
pantalla    .equ    0xFF00
teclado     .equ    0XFF02
fin         .equ    0xFF01

            .globl  jugador_aleat

            .globl  imprime_cadena

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   jugador_aleat                              ;
;       genera el primer jugador aleatoriamente;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

peticion_entrada:
            .asciz  "\nIntroduce la ultima cifra de la hora actual->M (hh:mM): "
mensajeturno1:
            .asciz  "\nPrimer turno:Jugador 1\n"
mensajeturno2:
            .asciz  "\nPrimer turno:Jugador 2\n"


jugador_aleat:
            pshs    a
generador:
            ldx     #peticion_entrada
	    jsr	    imprime_cadena
            ldb     teclado

            cmpb    #'5
            bhi     jugador1    ;si el min de la hora es mayor que 5 juega primero el jugador 1

            ldx     #mensajeturno2  ;si no el segundo tiene el turno (o la maquina si no hay jugador 2)
            jsr     imprime_cadena
            ldb     #2              ;para saber en otras func quien tiene el primer turno
	    puls    a
	    rts
jugador1:
            ldx     #mensajeturno1
            jsr     imprime_cadena
            ldb     #1
	    puls    a
	    rts

