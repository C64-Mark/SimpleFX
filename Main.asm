*=$0801

        byte    $0E, $08, $0A, $00, $9E, $20, $28  
        byte    $32, $30, $36, $34, $29, $00, $00, $00

SimpleFX
        jsr Initialise
        jsr IRQ_Initialise

GameLoop
        LIBSCREEN_WAIT_V 250
        jsr GameFlow_Update
        jmp GameLoop

