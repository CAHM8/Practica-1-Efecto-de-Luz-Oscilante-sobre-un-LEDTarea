PROCESSOR 16F887
    
    #include <xc.inc>   
    CONFIG FOSC=INTRC_NOCLKOUT    
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=OFF
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
    
    CONFIG BOR4V=BOR40V
    CONFIG WRT=OFF
     
      GLOBAL mul 
    PSECT udata
 mul:
    DS 1
   
    PSECT resetVEC,class=CODE, delta=2
    resetvec:
    PAGESEL main
    goto main
    
   PSECT code
    main:
    BANKSEL ANSELH
    CLRF ANSELH
    BANKSEL PORTA 
    clrf PORTA
    BANKSEL TRISA       
    clrf TRISA
    loop:
    movlw 0b00000000    ;se colocan todos los pines del porta en 0
    movwf PORTA
    nop
   ronda1:
    RLF  PORTA,1         ;empieza un recorrimiento de un bit de derecha a izquierda
    BTFSS PORTA,7	 ;cuando la instruccion BTFSS detecta el estado logico 1 en el bit 7...
    goto ronda1		 ;salta la instruccion "goto ronda1" lo que hace que inicie "ronda 2"
   ronda2:
    RRF PORTA,1		 ;Inicia el recorrimiento del 1 desde el bit 7 al 0
    BTFSS PORTA,0	 ;cuando por fin ese 1 llega al bit 0 la instruccion BTFSS salta la...
    goto ronda2		 ;linea de codigo 46 devolviendo el programa a "ronda 1"
    goto ronda1		 ;que es donde inicia de nuevo la secuencia
    END
