	.include "common.h"
	.equ WAIT, 100000	@ 曲のテンポ

	@(その他必要な定数を定義する)
	.section .init
	.global _start
_start:
	mov	sp, #STACK
	@ (GPIO #19 を含め，GPIOの用途を設定する)
	ldr     r0, =GPIO_BASE            @ r0: GPIO_BASE に固定
	@ GPIO #19 を出力用に設定
	mov     r1, #(1 << (3 * (SPK_PORT % 10) + 1))	@ +1を忘れずに！
	str     r1, [r0, #(GPFSEL0 + SPK_PORT / 10 * 4)]

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

	@ ********** start **********
	mov	r2, #0		@ index
	ldr	r3, =score	@ address
loop:
	ldrb	r1, [r3, r2]	@ 周波数
	add	r2, r2, #1
	ldrb	r4, [r3, r2]	@ 長さ
	add	r2, r2, #1
	mov	r5, #10
	mul	r1, r5, r1	@ 正しい周波数
	ldr	r5, =PWM_HZ
	udiv	r1, r5, r1	@ PWM_HZ / 周波数
	cmp	r4, #0
	beq	end
	bl	sound
	b	loop

	@ ********** おしまい **********
end:	
	mov	r1, #0
	str    	r1, [r0, #PWM_DAT2]	@ 音を止める
hoge:
	b    hoge
	@ ********** サブルーチン **********

sound:
	cmp	r1, #0
	strne	r1, [r0, #PWM_RNG2]
	lsr	r1, r1, #1
	str	r1, [r0, #PWM_DAT2]
	@ 待ち時間
	ldr	r1, =WAIT
	mul	r1, r4, r1
1:	subs	r1, r1, #1
	bne	1b
	bx	r14
	
	@  全音符 32
	@ 2分音符 16
	@ 4分音符  8
	@ 8分音符  4
	@16分音符  2 
	@32分音符  1
	@ 16分連続同じ音: 32分鳴らして32分とめる
score:
	.byte 0, 16, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0 ,2, F5, 2, 0, 2
	.byte G5, 8, 0, 8, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0, 2, F5, 2, 0, 2
	.byte G5, 8, 0, 8, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0, 2, F5, 2, 0, 2
	
	.byte G5, 8, G5, 4, Gs5, 4, Gs5, 8, G5, 4, 0, 4
	.byte G5, 4, 0, 4, F5, 4, 0, 4, Ds5, 2, 0, 2, F5, 4, 0, 4, Ds5, 4
	.byte Ds5, 8, 0, 8, Ds5, 2, 0, 2, F5, 4, 0, 4, G5, 4
	.byte G5, 4, 0, 4, G5, 8, F5, 4, Ds5, 8, 0, 4
	
	.byte Ds5, 16, G5, 8, F5, 4, F5, 2, 0, 2
	.byte F5, 8, 0, 8, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0, 2, F5, 2, 0, 2
	.byte G5, 8, 0, 8, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0, 2, F5, 2, 0, 2
	.byte G5, 8, 0, 8, Ds5, 2, 0, 2, Ds5, 2, 0, 2, F5, 2, 0, 2, F5, 2, 0, 2

	.byte G5, 8, G5, 4, Gs5, 4, Gs5, 8, G5, 4, 0, 4
	.byte G5, 4, 0, 4, F5, 4, 0, 4, Ds5, 2, 0, 2, F5, 4, 0, 4, Ds5, 4
	.byte Ds5, 8, 0, 8, G5, 8, G5, 4, F5, 4

	.byte F5, 8, Ds5, 4, 0, 4, Ds5, 2, 0, 2, F5, 8, Ds5, 2, 0, 2
	.byte Ds5, 8, As4, 8, Ds5, 8, F5, 8
	.byte Gs5, 4, G5, 8, Ds5, 8, F5, 8, Ds5, 2, Ds5, 1, 0, 1
	.byte Ds5, 16, 0, 16
	
	.byte 0, 0
