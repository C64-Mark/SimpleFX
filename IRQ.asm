IRQ_Initialise
        sei
        lda #<IRQ_Main
        sta sysIntVectorLo_0314
        lda #>IRQ_Main
        sta sysIntVectorHi_0315
        cli
        rts


IRQ_Main
        jsr IRQ_PlaySound1
        jsr IRQ_PlaySound2
        jsr IRQ_PlaySound3
        jmp krnINTERRUPT


IRQ_PlaySound1
        dec voice1Counter
        beq .PlayV1Sound
        rts
.PlayV1Sound
        lda voice1Delay
        sta voice1Counter
        jsr Sound_PlaySound1
        rts


IRQ_PlaySound2
        dec voice2Counter
        beq .PlayV2Sound
        rts
.PlayV2Sound
        lda voice2Delay
        sta voice2Counter
        jsr Sound_PlaySound2
        rts


IRQ_PlaySound3
        dec voice3Counter
        beq .PlayV3Sound
        rts
.PlayV3Sound
        lda voice3Delay
        sta voice3Counter
        jsr Sound_PlaySound3
        rts