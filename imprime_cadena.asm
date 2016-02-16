            .module cadenas

pantalla    .equ    0xFF00  ;constante
teclado     .equ    0XFF02
fin         .equ    0xFF01
            .globl  imprime_cadena
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   imprime_cadena                                     ;
;       Saca una cadena de texto por pantalla          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imprime_cadena:

            pshs   a
siguiente:  lda    ,x+
            beq    ret_imprime_cadena ;si el resultado es 0 (la cadena se termina)
            sta    pantalla
            bra    siguiente
ret_imprime_cadena:
            puls    a
            rts
