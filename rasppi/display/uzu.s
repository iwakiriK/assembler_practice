	.equ GPIO_BASE, 0x3f200000 @GPIOベースアドレス
	.equ GPFSEL0, 0x00 @GPIOポートの機能を選択する番地のオフセット
	.equ GPSET0, 0x1c @GPIOポートの出力値を1にするための番地のオフセット
	.equ GPCLR0, 0x28 @GPIOポートの出力値を0にするための番地のオフセット

	.equ GPFSEL_VEC0, 0x01201000 @GPFSEL0に設定する値(GPIO #4, #7, #8を出力用に設定)
	.equ GPFSEL_VEC1, 0x01249041 @GPFSEL1に設定する値(GPIO #10, #12, #14, #15, #16, #17, #18を出力用に設定)
	.equ GPFSEL_VEC2, 0x00209249 @GPFSEL2に設定する値(GPIO #20, #21, #22, #23, #24, #25, #27を出力用に設定)
	.equ WAIT, 0xff		@ 待ち時間
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
	.equ STACK, 0x8000

	.section .init
	.global _start

_start:
	@LEDとディスプレイ用のIOポートを出力に設定する
	mov	sp, #STACK
	ldr     r0, =GPIO_BASE
	ldr     r1, =GPFSEL_VEC0
	str     r1, [r0, #GPFSEL0 + 0]
	ldr     r1, =GPFSEL_VEC1
	str     r1, [r0, #GPFSEL0 + 4]
	ldr     r1, =GPFSEL_VEC2
	str     r1, [r0, #GPFSEL0 + 8]
	ldr	r2, =frame_buffer

	mov	r3, #0
	
loop:
	cmp	r3, #8
	moveq	r3, #0				@ r3=8のときr3=0
	ldrb	r4, [r2, r3]

	mov	r1, #(1 << COL1_PORT)
	tst	r4, #(1 << 7)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL2_PORT)
	tst	r4, #(1 << 6)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL3_PORT)
	tst	r4, #(1 << 5)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL4_PORT)
	tst	r4, #(1 << 4)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL5_PORT)
	tst	r4, #(1 << 3)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL6_PORT)
	tst	r4, #(1 << 2)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL7_PORT)
	tst	r4, #(1 << 1)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	mov	r1, #(1 << COL8_PORT)
	tst	r4, #(1 << 0)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]

	@ 行
	mov	r1, #(1 << ROW1_PORT)
	cmp	r3, #0
	strne	r1, [r0, #GPSET0]	
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW2_PORT)
	cmp	r3, #1
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW3_PORT)
	cmp	r3, #2
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW4_PORT)
	cmp	r3, #3
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW5_PORT)
	cmp	r3, #4
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW6_PORT)
	cmp	r3, #5
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW7_PORT)
	cmp	r3, #6
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	mov	r1, #(1 << ROW8_PORT)
	cmp	r3, #7
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

	ldr	r1, =WAIT
1:	subs	r1, r1, #1			@ r1--
	bne	1b				
	
	add	r3, r3, #1			@ r3++
	
	b	loop
	
end:	b	end
	
	.section .data
frame_buffer:
	.byte 0x1e, 0x21, 0x4c, 0x92, 0x49, 0x22, 0x14, 0x08
