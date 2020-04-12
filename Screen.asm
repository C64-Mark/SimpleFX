Screen_UpdateScreen
        lda screenChangeFlag
        bne .UpdateScreen
        rts
.UpdateScreen
        lda #FALSE
        sta screenChangeFlag
        LIBSCREEN_DISPLAY_VOICE_DATA_VA ATT_SCNROW, voice1Attack
        LIBSCREEN_DISPLAY_VOICE_DATA_VA DEC_SCNROW, voice1Decay
        LIBSCREEN_DISPLAY_VOICE_DATA_VA SUS_SCNROW, voice1Sustain
        LIBSCREEN_DISPLAY_VOICE_DATA_VA REL_SCNROW, voice1Release
        LIBSCREEN_DISPLAY_VOICE_DATA_VA FRL_SCNROW, voice1FreqL
        LIBSCREEN_DISPLAY_VOICE_DATA_VA FRH_SCNROW, voice1FreqH
        LIBSCREEN_DISPLAY_VOICE_DATA_VA PUL_SCNROW, voice1PulseL
        LIBSCREEN_DISPLAY_VOICE_DATA_VA PUH_SCNROW, voice1PulseH
        LIBSCREEN_DISPLAY_VOICE_DATA_VA DLY_SCNROW, voice1Delay

        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice1Voice, tbl_VoiceTypes, V1_OFFSET
        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice2Voice, tbl_VoiceTypes, V2_OFFSET
        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice3Voice, tbl_VoiceTypes, V3_OFFSET
        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice1RingMod, tbl_RingMod, V1_OFFSET+80
        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice2RingMod, tbl_RingMod, V2_OFFSET+80
        LIBSCREEN_DISPLAY_VOICE_TEXT_AAV voice3RingMod, tbl_RingMod, V3_OFFSET+80

        lda #$30
        sta SCNVOL
        sta SCNVOL+1
        lda volume
        cmp #10
        bcc .OneVolDigit
        inc SCNVOL
        sec
        sbc #10
.OneVolDigit
        ora #$30
        sta SCNVOL+1       
        rts


Screen_DisplayDecimal
        sta displayValue
        lda #0
        sta scnDigits
        sta scnDigits+1
        ldx #8
        sed
.ConvertToBCDLoop
        asl displayValue
        lda scnDigits+1
        adc scnDigits+1
        sta scnDigits+1
        lda scnDigits
        adc scnDigits
        sta scnDigits
        dex
        bne .ConvertToBCDLoop
        cld
        lda scnDigits
        ora #$30
        sta (zpLow),y
        iny
        lda scnDigits+1
        tax
        and #$F0
        lsr
        lsr
        lsr
        lsr
        ora #$30
        sta (zpLow),y
        iny
        txa
        and #$0F
        ora #$30
        sta (zpLow),y      
        rts


Screen_FlashCursor
        dec cursorCounter
        bne .ExitFlashCursor
        lda #CURSOR_FLASH_RATE
        sta cursorCounter
        inc SPRCOL0
.ExitFlashCursor
        rts


Screen_ItemSelected
        lda #BLACK
        sta SPRCOL0
        lda cursorY
        cmp #9
        bne .CheckVoiceType
        ldx cursorX
        lda tbl_Offsets,x
        tax
        lda voice1RingMod,x
        eor #1
        sta voice1RingMod,x
        jmp .ExitItemSelected
.CheckVoiceType
        cmp #8
        bne .DataValueSelected
        ldx cursorX
        lda tbl_Offsets,x
        tax
        lda voice1Voice,x
        cmp #4
        bne .IncreaseVoiceType
        lda #0
        sta voice1Voice,x
        jmp .ExitItemSelected
.IncreaseVoiceType
        inc voice1Voice,x
        jmp .ExitItemSelected
.DataValueSelected
        ldy cursorX
        lda tbl_CursorScreenX,y
        tay
        ldx cursorY
        lda tbl_CursorScreenY,x
        tax
        lda tbl_ScnPointerLo,x
        sta zpLow
        lda tbl_ScnPointerHi,x
        sta zpHigh
        ldx cursorX
        lda tbl_Offsets,x
        clc
        adc #$10
        sta dataPointer
        lda #0
        sta dataPointer+1
        jsr Screen_SaveChars
.FlashCharLoop
        jsr Screen_FlashChar
        dec digitChangeCounterMinor
        lda digitChangeCounterMinor
        bne .FlashCharLoop
        dec digitChangeCounterMajor
        lda digitChangeCounterMajor
        bne .FlashCharLoop
        lda #JOY_INCDEC_RATE
        sta digitChangeCounterMajor
        LIBJOY_GETJOY_V JOY_UP
        bne .CheckDecrease        
        sty zpTemp
        ldy cursorY
        lda (dataPointer),y
        cmp tbl_MaxValue,y
        bne .IncrementValue
        ldy zpTemp
        jmp .FlashCharLoop
.IncrementValue
        clc
        adc #1
.StoreNewValue
        sta (dataPointer),y
        ldy zpTemp
        jsr Screen_DisplayDecimal
        dey
        dey
        jsr Screen_SaveChars
        jmp .FlashCharLoop
.CheckDecrease
        LIBJOY_GETJOY_V JOY_DOWN
        bne .CheckFinished     
        sty zpTemp
        ldy cursorY
        lda (dataPointer),y
        cmp #0
        bne .DecrementValue
        ldy zpTemp
        jmp .FlashCharLoop
.DecrementValue
        sec
        sbc #1
        jmp .StoreNewValue
.CheckFinished
        LIBJOY_GETJOY_V JOY_FIRE
        bne .FlashCharLoop
.ExitItemSelected
        lda #TRUE
        sta screenChangeFlag
        rts


Screen_SaveChars
        lda (zpLow),y
        sta tmpChar
        iny
        lda (zpLow),y
        sta tmpChar+1
        iny
        lda (zpLow),y
        sta tmpChar+2
        dey
        dey
        rts


Screen_FlashChar
        lda sysTI_A2
        and #8
        cmp #8
        beq .ShowChar
        lda #CHAR_SPACE
        sta (zpLow),y
        iny
        sta (zpLow),y
        iny
        sta (zpLow),y
        jmp .ExitFlashChar
.ShowChar
        lda tmpChar
        sta (zpLow),y
        iny
        lda tmpChar+1
        sta (zpLow),y
        iny
        lda tmpChar+2
        sta (zpLow),y
.ExitFlashChar
        dey
        dey
        rts
