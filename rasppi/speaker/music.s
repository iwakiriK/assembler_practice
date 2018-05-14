	.include "common.h"
	.equ WAIT, 400000

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
	ldr	r1, [r3, r2]	@ 音階
	add	r2, r2, #4
	ldr	r4, [r3, r2]	@ 長さ
	add	r2, r2, #4
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
	
	@  全音符 16
	@ 2分音符  8
	@ 4分音符  4
	@ 8分音符  2
	@16分音符  1
score:
	.word C5, 4, D5, 4, E5, 4, F5, 4
	.word E5, 4, D5, 4, C5, 4,  0, 4
	.word E5, 4, F5, 4, G5, 4, A5, 4
	.word G5, 4, F5, 4, E5, 4,  0, 4
	.word C5, 4,  0, 4, C5, 4,  0, 4
	.word C5, 4,  0, 4, C5, 4,  0, 4
	.word C5, 1,  0, 1, C5, 1,  0, 1, D5, 1,  0, 1, D5, 1,  0, 1
	.word E5, 1,  0, 1, E5, 1,  0, 1, F5, 1,  0, 1, F5, 1,  0, 1
	.word E5, 4, D5, 4, C5, 4,  0, 4
	.word 0, 0
