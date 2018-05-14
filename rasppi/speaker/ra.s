	.equ PWM_HZ, 9600 * 1000
	.equ KEY_4A, PWM_HZ / 440       @ 440Hz のときの1周期のクロック数
	.equ GPIO_BASE,0x3f200000   	@ GPIOベースアドレス
	.equ GPFSEL0, 0x00   	    	@ GPIOポートの機能を選択する番地のオフセット
	.equ CM_BASE, 0x3f101000	@ クロックソース設定用BASE
	.equ CM_PWMCTL, 0xa0		@ クロックソース用
	.equ CM_PWMDIV, 0xa4		@ クロックソース用
	.equ PWM_BASE, 0x3f20c000	@ PWM制御のベースアドレス
	.equ PWM_RNG2, 0x20       	@ よくわからん
	.equ PWM_DAT2, 0x24	        @ よくわからん
	.equ PWM_CTL, 0x0               @ よくわからん
	.equ PWM_PORT, 19		@ PWMのポートアドレス

	@(その他必要な定数を定義する)
	.section .init
	.global _start
_start:
	@ (GPIO #19 を含め，GPIOの用途を設定する)
	ldr     r0, =GPIO_BASE            @ r0: GPIO_BASE に固定
	@ GPIO #19 を出力用に設定
	mov     r1, #(1 << (3 * (PWM_PORT % 10) + 1))	@ +1を忘れずに！
	str     r1, [r0, #(GPFSEL0 + PWM_PORT / 10 * 4)]


	@(PWM のクロックソースを設定する)
	ldr     r0, =CM_BASE
	ldr     r1, =0x5a000021                  
	str     r1, [r0, #CM_PWMCTL]
1:  
	ldr     r1, [r0, #CM_PWMCTL]
	tst     r1, #0x80
	bne     1b
	ldr     r1, =(0x5a000000 | (2 << 12))   
	str     r1, [r0, #CM_PWMDIV]
	ldr     r1, =0x5a000211                
	str     r1, [r0, #CM_PWMCTL]
	
	@(PWM の動作モードを設定する)
	ldr	r0, =PWM_BASE
	mov	r1, #(1 << 15)
	orr	r1, r1, #(1 << 8)
	str	r1, [r0, #PWM_CTL]
	
	@ ラの音を鳴らす
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

loop:
	b    loop
