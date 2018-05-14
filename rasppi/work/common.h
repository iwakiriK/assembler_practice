        @ GPIO関連
        .equ GPIO_BASE, 0x3f200000      @ GPIO_BASEアドレス
        .equ GPSET0, 0x1c               @ GPIOポートの出力値を 1 にするための番地オフセット
        .equ GPCLR0, 0x28               @ GPIOポートの出力値を 0 にするための番地オフセット
        .equ GPLEV0, 0x34               @ switchのオンオフを取得するためのオフセット
        .equ GPFSEL0, 0x00               @ GPFSELを設定するためのオフセット
        .equ GPFSEL_VEC0, 0x01201000    @ GPIO #4, #7, #8を出力用に
        @ str GPFSEL_VEC0, [GPIO_BASE, GPFSEL + 0]
        .equ GPFSEL_VEC1, 0x01249041    @ GPIO #10, #12, #14, #15, #16, #17, #18を出力用に
        .equ GPFSEL_VEC2, 0X00209249    @ GPIO #20, #21, #22, #23, #24, #25, #27を出力用に
        .equ STACK, 0x8000

        .equ LED_PORT, 10
        .equ SPK_PORT, 19
        @ SWITCH
        .equ SW1_PORT, 13              
        .equ SW2_PORT, 26
        .equ SW3_PORT, 5
        .equ SW4_PORT, 6

        @ DISPLAY 
        .equ COL1_PORT, 27
        .equ COL2_PORT, 8
        .equ COL3_PORT, 25
        .equ COL4_PORT, 23
        .equ COL5_PORT, 24
        .equ COL6_PORT, 22
        .equ COL7_PORT, 17
        .equ COL8_PORT, 4
        .equ ROW1_PORT, 14
        .equ ROW2_PORT, 15
        .equ ROW3_PORT, 21
        .equ ROW4_PORT, 18
        .equ ROW5_PORT, 12
        .equ ROW6_PORT, 20
        .equ ROW7_PORT, 7
        .equ ROW8_PORT, 16
        @ COL=ON && ROW=OFF -> 点灯
        .equ COL_ON, GPSET0
        .equ COL_OFF, GPCLR0
        .equ ROW_ON, GPSET0
        .equ ROW_OFF, GPCLR0

        @ TIMER関連
        .equ TIMER_BASE, 0x3f003000     @ TIMER_BASEアドレス
        .equ TIMER_LOW, 0x4             @ タイムカウンタの下32bitを参照するための番地オフセット
        .equ TIMER_HIGH, 0x8            @ タイムカウンタの上32bitを参照するための番地オフセット

        @ スピーカー設定
        .equ CM_BASE, 0x3f101000        
        .equ CM_PWMCTL, 0xa0
        .equ CM_PWMDIV, 0xa4
        .equ PWM_BASE, 0x3f20c000
        .equ PWM_RNG2, 0x20
        .equ PWM_DAT2, 0x24
        .equ PWM_CTL, 0x0
        .equ PWM_HZ, 9600 * 1000
        @ 音階周波数
        .equ A4,   44
        .equ As4,  47
        .equ B4,   49
        .equ C5,   52
        .equ Cs5,  55
        .equ D5,   59
        .equ Ds5,  62
        .equ E5,   66
        .equ F5,   70
        .equ Fs5,  74
        .equ G5,   78
        .equ Gs5,  83
        .equ A5,   88
	.equ As5,  93
	.equ B5,   99
	.equ C6,  105
        .equ Cs6, 111
	.equ D6,  118
	.equ Ds6, 125
	.equ E6,  132
	.equ F6,  140
	.equ Fs6, 148
	.equ G6,  157
	.equ Gs6, 166
	.equ A6,  176
        .equ PWM_CLR, 0
