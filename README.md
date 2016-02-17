Tres En Raya para el microprocesador 6809 de Motorola

Disponible con:

-Modo 1 jugador

-Modo 2 jugadores (maquina vs humano)

Necesario para usarlo el emulador para el 6809 (6809-emulator.tar) donde se incluye el ensamblador y enlazador:

-Descomprimir el 6809-emulator.tar con "tar xvf 6809-emulator.tar".Volver a abrir sesion para que se apliquen los cambios

-Si da problema "bash: /home/javserher/bin/as6809: No such file or directory" en 64bits, instalar el siguiente paquete "sudo apt-get install libc6-i386"

*Para ensamblar y enlazar o para ejecutar-en-un-paso se deben especificar todos los nombres de ficheros .asm (ensamblado) disponibles en este proyecto y a la hora de enlazar todos los .rel generados tras ensamblar *

EJECUCION-1-PASO:

ensambla <nombre_fichero.asm>

ENSAMBLADO,ENLAZADO,EJECUCIÓN:

as6809 -o <nombre_fichero.asm> --> Genera ficheros .rel

aslink -s <nombre_fichero.rel>

Para ejecutar tras ensamblado/enlazado:

m6809-run <nombre_fichero.s19>
