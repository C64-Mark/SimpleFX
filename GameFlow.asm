gfStatusJumpTableLo             byte <GameFlow_StatusMain
                                byte <GameFlow_StatusHelp
                                byte <GameFlow_StatusSelected

gfStatusJumpTableHi             byte >GameFlow_StatusMain
                                byte >GameFlow_StatusHelp
                                byte >GameFlow_StatusSelected


GameFlow_Update
        ldx gameStatus
        lda gfStatusJumpTableLo,x
        sta zpLow
        lda gfStatusJumpTableHi,x
        sta zpHigh
        jmp (zpLow)

GameFlow_StatusMain
        jsr Screen_UpdateScreen
        jsr Screen_FlashCursor
        jsr Input_GetKeys
        jsr Input_GetJoy
        rts


GameFlow_StatusHelp
        jsr Help_DisplayHelpScreen
        lda #GF_STATUS_MAIN
        sta gameStatus
        rts


GameFlow_StatusSelected
        jsr Screen_ItemSelected
        lda #GF_STATUS_MAIN
        sta gameStatus
        rts
