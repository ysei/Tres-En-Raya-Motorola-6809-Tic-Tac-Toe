##(ESPAÑOL) Tres En Raya para el microprocesador 6809 de Motorola 

### Disponible con:

-Modo 1 jugador 

-Modo 2 jugadores (maquina vs humano)

***


* Necesario para hacerlo funcionar los archivos del emulador para el 6809 disponibles para Linux (6809emu-UbuntuXXXX.tar En caso de usar una distro distinta a Ubuntu probar las dos versiones en la distribucion que se use) donde se incluye el ensamblador y enlazador: 

    -Descomprimir el archivo .tar con "tar xvf 6809emu-UbuntuXXXX.tar" donde XXXX es la version del archivo que estás intentando instalar.Volver a abrir sesion para que se apliquen los cambios

    -Si al ejecutar,ensamblar o enlazar da un problema del tipo "bash: /home/javserher/bin/as6809: No such file or directory" en 64bits, instalar el siguiente paquete "sudo apt-get install libc6-i386"


***

_**Para ensamblar y enlazar o para ejecutar-en-un-paso se deben especificar todos los nombres de ficheros .asm (ensamblado) disponibles en este proyecto y a la hora de enlazar todos los .rel generados tras ensamblar **_



**EJECUCION-1-PASO:** 

`ensambla <nombre_fichero.asm>`

**ENSAMBLADO,ENLAZADO,EJECUCIÓN:**

`as6809 -o <nombre_fichero.asm>` --> Genera ficheros .rel

`aslink -s <nombre_fichero.rel>`

Para ejecutar tras ensamblado/enlazado:
 
`m6809-run <nombre_fichero.s19>`

***
Problemas a resolver:

-Existe un problema que ocurre en ocasiones aleatorias a la hora de comprobar jugadas ganadoras.Se detallará en unos dias.

***

***
##(ENGLISH) Tic Tac Toe game for Motorola 6809 microprocessor

###Available:

-1 player mode

-2 players mode (Human vs Computer)

***

It is necesary to download the emulator archives (assembler,linker and executer) available for Linux (6809emu-UbuntuXXXX.tar If you use a different Linux distro from Ubuntu, just try both versions of the archives).
    
    -Decompress the file "tar xvf 6809emu-UbuntuXXXX.tar" where XXXX is the rest of the name of the version you are trying to install.After that, reopen your session to apply the changes.
    
    -If you receive an error in 64bits like "bash: /home/javserher/bin/as6809: No such file or directory" trying to assembly,linking or executing, install the following package "sudo apt-get install libc6-i386"
    
    ***
    
    _**When assemblying,linking or 1-step-executing you need to specify all .asm (while assemblying or 1-step-executing) or .rel files generated after assemblying for linking**_
    
    **1-STEP-EXECUTION**
    
    `ensambla <file_name.asm>`
    
    **ASSEMBLYING,LINKING AND EXECUTING**
    
    `as6809 -o <file_name.asm>` --> Generates .rel files

    `aslink -s <file_name.rel>`
    
    To execute finally:
    
    `m6809-run <file_name.s19>`
    

