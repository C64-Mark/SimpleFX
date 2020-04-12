Help_DisplayHelpScreen
        lda #0
        sta SPREN
        LIBSCREEN_COPYSCREEN_AA SCNHELP, COLHELP

.WaitHelpExit
        lda sysKeyCode_C5
        cmp #KEY_F1
        bne .WaitHelpExit
.HelpKeyDebounce
        lda sysKeyCode_C5
        cmp #KEY_NONE
        bne .HelpKeyDebounce

        LIBSCREEN_COPYSCREEN_AA SCNMAIN, COLMAIN
        lda #1
        sta SPREN
        lda #TRUE
        sta screenChangeFlag
        rts