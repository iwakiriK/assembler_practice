	.include "common.h"
	.section .init
	.global  _start
_start:
	mov	sp, #STACK
	@ screen
	ldr     r0, =GPIO_BASE            @ r0: GPIO_BASE に固定
	ldr     r1, =GPFSEL_VEC0
	str     r1, [r0, #GPFSEL0 + 0]
	ldr     r1, =GPFSEL_VEC1
	str     r1, [r0, #GPFSEL0 + 4]
	ldr     r1, =GPFSEL_VEC2
	str     r1, [r0, #GPFSEL0 + 8]
	@ music
	ldr	r1, [r0, #(GPFSEL0 + SPK_PORT / 10 * 4)]
	orr     r1, #(1 << (3 * (SPK_PORT % 10) + 1))	@ +1を忘れずに！
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

	bl	music

hoge:	b	hoge
