	.include "common.h"
	@(その他必要な定数を定義する)
	.section .init
	.global screen
screen:
	ldr	r8, =120000
	cmp	r6, r8
	ldreq	r5, =s1d	@ サイクロップス先輩
	ldr	r8, =150000
	cmp	r6, r8
	ldreq	r5, =s2d	@ バジリスク
	ldr	r8, =200000
	
	cmp	r6, r8
	ldreq	r5, =s3d	@ 変態糞土方
	ldr	r8, =60000
	cmp	r6, r8
	ldreq	r5, =s4d	@ 勝ち取りたいやつ
	mov	r8, #0
	cmp	r6, r8
	ldreq	r5, =s5d	@ 音符(何も再生していない時)
	
	ldr	r0, =GPIO_BASE
	mov	r7, #0		@ index
sloop:
	cmp	r7, #8
	beq	send
	moveq	r7, #0
	ldrb	r9, [r5, r7]

	mov	r11, #(1 << COL1_PORT)
	tst	r9, #(1 << 7)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL2_PORT)
	tst	r9, #(1 << 6)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL3_PORT)
	tst	r9, #(1 << 5)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL4_PORT)
	tst	r9, #(1 << 4)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL5_PORT)
	tst	r9, #(1 << 3)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL6_PORT)
	tst	r9, #(1 << 2)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL7_PORT)
	tst	r9, #(1 << 1)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	mov	r11, #(1 << COL8_PORT)
	tst	r9, #(1 << 0)
	streq	r11, [r0, #GPCLR0]
	strne	r11, [r0, #GPSET0]

	@ 行
	mov	r11, #(1 << ROW1_PORT)
	cmp	r7, #0
	strne	r11, [r0, #GPSET0]	
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW2_PORT)
	cmp	r7, #1
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW3_PORT)
	cmp	r7, #2
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW4_PORT)
	cmp	r7, #3
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW5_PORT)
	cmp	r7, #4
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW6_PORT)
	cmp	r7, #5
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW7_PORT)
	cmp	r7, #6
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r11, #(1 << ROW8_PORT)
	cmp	r7, #7
	strne	r11, [r0, #GPSET0]
	streq	r11, [r0, #GPCLR0]

	mov	r10, #0xff
1:	subs	r10, r10, #1			@ r1--
	bne	1b				
	
	add	r7, r7, #1			@ r3++
	
	b	sloop
	
send:
	bx	r14
	@*********************

s1d:
	.byte 0x11, 0x20, 0x7f, 0x7f, 0x20, 0x20, 0x2c, 0x1d
s2d:
	.byte 0x01, 0x2a, 0x28, 0x44, 0x44, 0x44, 0x82, 0x82
s3d:
	.byte 0xc3, 0xa5, 0xff, 0x81, 0xa5, 0x81, 0x99, 0xfe
s4d:
	.byte 0x18, 0x14, 0x12, 0x21, 0x2f, 0x70, 0xc0, 0x80
s5d:
	.byte 0x08, 0x0c, 0x0e, 0x0a, 0x08, 0x38, 0x78, 0x32
