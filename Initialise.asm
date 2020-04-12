Initialise
        LIBSCREEN_SETVIC_AVV VMCR, 240, CHARRAM
        lda #VOICE_OFF 
        sta VCREG1
        sta VCREG2
        sta VCREG3
        ldy #34
        lda #0
.InitVariablesLoop
        sta voice1Attack-1,y
        dey
        bne .InitVariablesLoop
        lda #BLACK
        sta BGCOL0
        sta BDCOL
        LIBSCREEN_COPYSCREEN_AA SCNMAIN, COLMAIN

        lda #SPRITERAM
        sta SPRPTR0
        lda #1
        sta SPREN
        lda #144
        sta SPRX0
        lda #80
        sta SPRY0
        lda #0
        sta cursorX
        sta cursorY
        lda #RED
        sta SPRCOL0
        lda #CURSOR_FLASH_RATE
        sta cursorCounter
        lda #JOY_INPUT_RATE
        sta joyCounter
        lda #JOY_INCDEC_RATE
        sta digitChangeCounterMajor
        lda #$1E
        sta voice1Delay
        sta voice2Delay
        sta voice3Delay
        sta voice1Counter
        sta voice2Counter
        sta voice3Counter
        lda #GF_STATUS_MAIN
        sta gameStatus
        rts