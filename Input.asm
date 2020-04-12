Input_GetKeys
        lda sysKeyCode_C5
        cmp #KEY_GT
        bne .CheckLessThan
        lda #TRUE
        sta screenChangeFlag
        inc volume
        lda volume
        cmp #16
        bne .KeyDebounce
        lda #15
        sta volume
        jmp .KeyDebounce
.CheckLessThan
        cmp #KEY_LT
        bne .CheckClearSound
        lda #TRUE
        sta screenChangeFlag
        dec volume
        lda volume
        cmp #255
        bne .KeyDebounce
        lda #0
        sta volume
        jmp .KeyDebounce
.CheckClearSound
        cmp #KEY_RETURN
        bne .CheckHelpKey
        lda #VOICE_OFF
        sta VCREG1
        sta VCREG2
        sta VCREG3
        sta voice1Voice
        sta voice2Voice
        sta voice3Voice
        lda #TRUE
        sta screenChangeFlag
        jmp .KeyDebounce
.CheckHelpKey
        cmp #KEY_F1
        bne .ExitGetKeys
        lda #GF_STATUS_HELP
        sta gameStatus
        jmp .KeyDebounce
.KeyDebounce
        lda sysKeyCode_C5
        cmp #KEY_NONE
        bne .KeyDebounce
.ExitGetKeys
        rts


Input_GetJoy
        dec joyCounter
        beq .GetJoy
        rts
.GetJoy
        lda #JOY_INPUT_RATE
        sta joyCounter
        LIBJOY_GETJOY_V JOY_UP
        bne .CheckJoyDown
        lda cursorY
        beq .ExitGetJoy
        dec cursorY
        jmp .ExitGetJoy
.CheckJoyDown
        LIBJOY_GETJOY_V JOY_DOWN
        bne .CheckJoyLeft
        lda cursorY
        cmp #10
        beq .ExitGetJoy
        inc cursorY
        jmp .ExitGetJoy
.CheckJoyLeft 
        LIBJOY_GETJOY_V JOY_LEFT
        bne .CheckJoyRight
        lda cursorX
        beq .ExitGetJoy
        dec cursorX
        jmp .ExitGetJoy 
.CheckJoyRight    
        LIBJOY_GETJOY_V JOY_RIGHT
        bne .CheckJoyFire
        lda cursorX
        cmp #2
        beq .ExitGetJoy
        inc cursorX
        jmp .ExitGetJoy
.CheckJoyFire
        LIBJOY_GETJOY_V JOY_FIRE
        bne .ExitGetJoy
        lda #GF_STATUS_SELECTED
        sta gameStatus
.ExitGetJoy
        ldx cursorX
        ldy cursorY
        lda tbl_CursorX,x
        sta SPRX0
        lda tbl_CursorXHi,x
        sta SPRXMSB
        lda tbl_CursorY,y
        sta SPRY0
        rts


