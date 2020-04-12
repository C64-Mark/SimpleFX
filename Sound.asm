Sound_PlaySound1
        lda #VOICE_OFF
        sta VCREG1
        lda volume
        sta SIDVOL
        lda voice1Attack
        asl
        asl
        asl
        asl
        ora voice1Decay
        sta ATDCY1
        lda voice1Sustain
        asl
        asl
        asl
        asl
        ora voice1Release
        sta SUREL1
        lda voice1FreqL
        sta FREL1
        lda voice1FreqH
        sta FREH1
        lda voice1PulseL
        sta PWL1
        lda voice1PulseH
        sta PWH1
        ldx voice1Voice
        lda voice1RingMod
        asl
        asl
        ora tbl_VoiceTypeValue,x
        sta VCREG1
        rts


Sound_PlaySound2
        lda #VOICE_OFF
        sta VCREG2
        lda volume
        sta SIDVOL
        lda voice2Attack
        asl
        asl
        asl
        asl
        ora voice2Decay
        sta ATDCY2
        lda voice2Sustain
        asl
        asl
        asl
        asl
        ora voice2Release
        sta SUREL2
        lda voice2FreqL
        sta FREL2
        lda voice2FreqH
        sta FREH2
        lda voice2PulseL
        sta PWL2
        lda voice2PulseH
        sta PWH2
        ldx voice2Voice
        lda voice2RingMod
        asl
        asl
        ora tbl_VoiceTypeValue,x
        sta VCREG2
        rts


Sound_PlaySound3
        lda #VOICE_OFF
        sta VCREG3
        lda volume
        sta SIDVOL
        lda voice3Attack
        asl
        asl
        asl
        asl
        ora voice3Decay
        sta ATDCY3
        lda voice3Sustain
        asl
        asl
        asl
        asl
        ora voice3Release
        sta SUREL3
        lda voice3FreqL
        sta FREL3
        lda voice3FreqH
        sta FREH3
        lda voice3PulseL
        sta PWL3
        lda voice3PulseH
        sta PWH3
        ldx voice3Voice
        lda voice3RingMod
        asl
        asl
        ora tbl_VoiceTypeValue,x
        sta VCREG3
        rts


