; Copy screen and colour data to display ram
defm    LIBSCREEN_COPYSCREEN_AA ;address of screen, address of colour
        ldx #0
@loop   
        lda /1,x
        sta SCREENRAM,x
        lda /1+250,x
        sta SCREENRAM+250,x
        lda /1+500,x
        sta SCREENRAM+500,x
        lda /1+750,x
        sta SCREENRAM+750,x
        lda /2,x
        sta COLOURRAM,x
        lda /2+250,x
        sta COLOURRAM+250,x
        lda /2+500,x
        sta COLOURRAM+500,x
        lda /2+750,x
        sta COLOURRAM+750,x
        inx
        cpx #251
        bne @loop
        endm


; Set VIC video modes
defm    LIBSCREEN_SETVIC_AVV ;VICRegister, Clear, Set
        lda /1
        and #/2
        ora #/3
        sta /1
        endm


defm    LIBSCREEN_DISPLAY_VOICE_DATA_VA
        ldx #/1
        lda tbl_ScnPointerLo,x
        sta zpLow
        lda tbl_ScnPointerHi,x
        sta zpHigh

        ldy #V1_OFFSET
        lda /2
        jsr Screen_DisplayDecimal

        ldy #V2_OFFSET
        lda /2+11
        jsr Screen_DisplayDecimal

        ldy #V3_OFFSET
        lda /2+22
        jsr Screen_DisplayDecimal
        endm


defm LIBSCREEN_DISPLAY_VOICE_TEXT_AAV
        ldx #0
        lda /1,x
        asl
        asl
        sec
        sbc /1,x
        tax
        lda /2,x
        ldy #/3
        sta SCNVOC,y
        inx
        iny
        lda /2,x        
        sta SCNVOC,y
        inx
        iny
        lda /2,x        
        sta SCNVOC,y
        endm


; Get input for joystick in port 2
defm    LIBJOY_GETJOY_V ; JoystickDirection
        lda CIAPRA
        and #/1
        endm ; test with bne on return


; Wait for raster line
defm    LIBSCREEN_WAIT_V ;Line number
@loop   lda #/1
        cmp RASTER
        bne @loop
        endm