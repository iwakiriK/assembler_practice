	.equ PWM_HZ, 9600 * 1000
	.equ KEY_A4, PWM_HZ / 440       @ 440Hz のときの1周期のクロック数 ラ
	.equ KEY_B4, PWM_HZ / 494	@ 494Hz のときの1周期のクロック数 シ
	.equ KEY_C5, PWM_HZ / 523	@ 523Hz のときの1周期のクロック数 ド
	.equ KEY_D5, PWM_HZ / 587	@ 587Hz のときの1周期のクロック数 レ
	.equ KEY_E5, PWM_HZ / 659	@ 659Hz のときの1周期のクロック数 ミ
	.equ KEY_F5, PWM_HZ / 698	@ 698Hz のときの1周期のクロック数 ファ
	.equ KEY_G5, PWM_HZ / 784	@ 784Hz のときの1周期のクロック数 ソ
	.equ KEY_A5, PWM_HZ / 880	@ 880Hz のときの1周期のクロック数 ラ
	.equ GPIO_BASE,0x3f200000   	@ GPIOベースアドレス
	.equ GPFSEL0, 0x00   	    	@ GPIOポートの機能を選択する番地のオフセット
	.equ CM_BASE, 0x3f101000	@ クロックソース設定用BASE
	.equ CM_PWMCTL, 0xa0		@ クロックソース用
	.equ CM_PWMDIV, 0xa4		@ クロックソース用
	.equ PWM_BASE, 0x3f20c000	@ PWM制御のベースアドレス
	.equ PWM_RNG2, 0x20
	.equ PWM_DAT2, 0x24
	.equ PWM_CTL, 0x0
	.equ PWM_PORT, 19		@ PWMのポートアドレス

	.equ WAIT, 0x2fffff
	.equ STACK, 0x8000

	@(その他必要な定数を定義する)
	.section .init
	.global _start
_start:
	mov	sp, #STACK
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
	ldr    r1, =KEY_A4
	bl	wait

	@ シの音を鳴らす
	ldr    r1, =KEY_B4
	bl	wait

	@ ドの音を鳴らす
	ldr    r1, =KEY_C5
	bl	wait

	@ レの音を鳴らす
	ldr    r1, =KEY_D5
	bl	wait

	@ ミの音を鳴らす
	ldr    r1, =KEY_E5 
	bl	wait

	@ ファの音を鳴らす
	ldr    r1, =KEY_F5
	bl	wait

	@ ソの音を鳴らす
	ldr    r1, =KEY_G5
	bl	wait

	@ ラの音を鳴らす
	ldr    r1, =KEY_A5
	bl	wait
	mov	r1, #0
	str    	r1, [r0, #PWM_DAT2]	@ 音を止める

loop:
	b    loop

wait:
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]
	@ 待ち時間
	ldr	r1, =WAIT
1:	subs	r1, r1, #1
	bne	1b
	bx	r14
