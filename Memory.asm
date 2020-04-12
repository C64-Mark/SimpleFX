
zpLow                           = $02
zpHigh                          = $03
gameStatus                      = $04
dataPointer                     = $05 ;to 06
zpTemp                          = $07


voice1Attack                    = $10
voice1Decay                     = $11
voice1Sustain                   = $12
voice1Release                   = $13
voice1FreqL                     = $14
voice1FreqH                     = $15
voice1PulseL                    = $16
voice1PulseH                    = $17
voice1Voice                     = $18
voice1RingMod                   = $19
voice1Delay                     = $1A

voice2Attack                    = $1B
voice2Decay                     = $1C
voice2Sustain                   = $1D
voice2Release                   = $1E
voice2FreqL                     = $1F
voice2FreqH                     = $20
voice2PulseL                    = $21
voice2PulseH                    = $22
voice2Voice                     = $23
voice2RingMod                   = $24
voice2Delay                     = $25

voice3Attack                    = $26
voice3Decay                     = $27
voice3Sustain                   = $28
voice3Release                   = $29
voice3FreqL                     = $2A
voice3FreqH                     = $2B
voice3PulseL                    = $2C
voice3PulseH                    = $2D
voice3Voice                     = $2E
voice3RingMod                   = $2F
voice3Delay                     = $30

volume                          = $31
displayValue                    = $32
scnDigits                       = $33 ;to $34
cursorX                         = $35
cursorXHi                       = $36
cursorY                         = $37
cursorCounter                   = $38
joyCounter                      = $39
screenChangeFlag                = $3A

digitChangeCounterMinor         = $3B
digitChangeCounterMajor         = $3C

tmpChar                         = $40 ;to $42

voice1Counter                   = $50
voice2Counter                   = $51
voice3Counter                   = $52

sysTI_A2                        = $A2
sysKeyCode_C5                   = $C5
sysIntVectorLo_0314             = $0314
sysIntVectorHi_0315             = $0315


*=$1000
tbl_ScnPointerLo                byte $00, $28, $50, $78, $a0, $c8, $f0, $18
                                byte $40, $68, $90, $b8, $e0, $08, $30, $58
                                byte $80, $a8, $d0, $f8, $20, $48, $70, $98, $c0

tbl_ScnPointerHi                byte $04, $04, $04, $04, $04, $04, $04, $05
                                byte $05, $05, $05, $05, $05, $06, $06, $06
                                byte $06, $06, $06, $06, $07, $07, $07, $07, $07

tbl_CursorX                     byte 144, 216, 32
tbl_CursorXHi                   byte 0, 0, 1
tbl_CursorY                     byte 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240

tbl_CursorScreenX               byte 15, 24, 33
tbl_CursorScreenY               byte 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
tbl_OffSets                     byte 0, 11, 22
tbl_MaxValue                    byte 15, 15, 15, 15, 255, 255, 255, 255, 4, 1, 255


tbl_VoiceTypes                  text 'off'
                                text 'tri'
                                text 'saw'
                                text 'rec'
                                text 'noi'

tbl_VoiceTypeValue              byte 00, 17, 33, 65, 129

tbl_RingMod                     text ' no'
                                text 'yes'

spriteNumberMask                byte %00000001, %00000010, %00000100, %00001000
                                byte %00010000, %00100000, %01000000, %10000000


;screen data
SCNMAIN                         = $2000
COLMAIN                         = $23E8
SCNHELP                         = $27d0
COLHELP                         = $2bb8

*=$2000
                                incbin "scnSimpleFX.bin"


;character set
CHARRAM         = 12
*=$3000
                                incbin "charsSimpleFX.cst", 0, 63


;sprite data
SPRITERAM       = 224
*=$3800
                                incbin "spritesSimpleFX.spt", 1, 1, true



