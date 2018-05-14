    .equ GPIO_BASE, 0x3f200000 @GPIOベースアドレス
	.equ GPFSEL0, 0x00 @GPIOポートの機能を選択する番地のオフセット
	.equ GPSET0, 0x1c @GPIOポートの出力値を1にするための番地のオフセット
	.equ GPCLR0, 0x28 @GPIOポートの出力値を0にするための番地のオフセット

	.equ GPFSEL_VEC0, 0x01201000 @GPFSEL0に設定する値(GPIO #4, #7, #8を出力用に設定)
	.equ GPFSEL_VEC1, 0x01249041 @GPFSEL1に設定する値(GPIO #10, #12, #14, #15, #16, #17, #18を出力用に設定)
	.equ GPFSEL_VEC2, 0x00209249 @GPFSEL2に設定する値(GPIO #20, #21, #22, #23, #24, #25, #27を出力用に設定)
	.equ WAIT, 0xff
	.equ WAIT2, 0x10

	.equ TIMER_BASE, 0x3f003000	@ TIMER BASE ADDRESS
	.equ TIMER_LOW, 0x4		@ TIMER COUNTER LOW OFFSET
	.equ TIMER_HIGH, 0x8		@ TIMER COUNTER HIGHT OFFSET
	
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
	.equ SEC, 0x186a0
	

	.section .init
	.global _start

_start:
	@ディスプレイ用のIOポートを出力に設定する
	mov	sp, #STACK
	ldr     r0, =GPIO_BASE
	ldr     r1, =GPFSEL_VEC0
	str     r1, [r0, #GPFSEL0 + 0]
	ldr     r1, =GPFSEL_VEC1
	str     r1, [r0, #GPFSEL0 + 4]
	ldr     r1, =GPFSEL_VEC2
	str     r1, [r0, #GPFSEL0 + 8]
	mov	r2, #0		@ 1の位
	mov	r3, #0		@ 10の位
    @フレームバッファとタイマーの設定
	ldr	r5, =frame_buffer
	ldr	r10, =TIMER_BASE
	ldr	r4, =SEC

@メインの処理
loop:
	@ 10の位を取ってくる
	cmp	r3, #0
	ldreq	r6, =dot0
	cmp	r3, #1
	ldreq	r6, =dot1
	cmp	r3, #2
	ldreq	r6, =dot2
	cmp	r3, #3
	ldreq	r6, =dot3
	cmp	r3, #4
	ldreq	r6, =dot4
	cmp	r3, #5
	ldreq	r6, =dot5
	cmp	r3, #6
	ldreq	r6, =dot6
	cmp	r3, #7
	ldreq	r6, =dot7
	cmp	r3, #8
	ldreq	r6, =dot8
	cmp	r3, #9
	ldreq	r6, =dot9
	bl	fb1		@ フレームバッファにぶちこむ
	
	@ 1の位を取ってくる
	cmp	r2, #0
	ldreq	r6, =dot0
	cmp	r2, #1
	ldreq	r6, =dot1
	cmp	r2, #2
	ldreq	r6, =dot2
	cmp	r2, #3
	ldreq	r6, =dot3
	cmp	r2, #4
	ldreq	r6, =dot4
	cmp	r2, #5
	ldreq	r6, =dot5
	cmp	r2, #6
	ldreq	r6, =dot6
	cmp	r2, #7
	ldreq	r6, =dot7
	cmp	r2, #8
	ldreq	r6, =dot8
	cmp	r2, #9
	ldreq	r6, =dot9
	bl	fb2		@ フレームバッファにぶちこむ
	bl	output		@ フレームバッファの中身を出力

	bl	update

	b   loop

hoge:	b	hoge
@タイマーの読み出し、桁上がり、100になったときの初期化	
update:	
	ldr	r12, [r10, #TIMER_LOW] @タイマーの読み出し
	udiv	r7, r12, r4
	cmp	r7, #0
	bxeq	r14

	ldr	r7, =SEC
	add	r4, r4, r7
	
	add	r2, r2, #1
	cmp	r2, #10		@ 桁上がり
	addeq	r3, r3, #1
	moveq	r2, #0
	cmp	r3, #10		@ 初期化
	moveq	r3, #0
	bx	r14

@10の位の処理
fb1:	
	mov	r7, #0		@ (0 ~ 7)
fb1loop:
	cmp	r7, #8
	beq	fb1end
	ldrb	r8, [r6, r7]
	strb	r8, [r5, r7]
	add	r7, r7, #1	@ r7++
	b	fb1loop
fb1end:	
	bx	r14

@1の位の処理
fb2:
	mov	r7, #0
fb2loop:	
	cmp	r7, #8
	beq	fb2end
	ldrb	r8, [r6, r7]
	lsr	r8, #4		@ 1の位
	ldrb	r9, [r5, r7]
	orr	r8, r8, r9
	strb	r8, [r5, r7]
	add	r7, r7, #1	@ r7++
	b	fb2loop
fb2end:		
	bx	r14

@ディスプレイの表示
output:
	mov	r6, #0
oploop:
	cmp	r6, #8
	beq	opend
	ldrb	r7, [r5, r6]
    @ 列
	mov	r1, #(1 << COL1_PORT)
	tst	r7, #(1 << 7)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL2_PORT)
	tst	r7, #(1 << 6)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL3_PORT)
	tst	r7, #(1 << 5)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL4_PORT)
	tst	r7, #(1 << 4)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL5_PORT)
	tst	r7, #(1 << 3)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL6_PORT)
	tst	r7, #(1 << 2)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL7_PORT)
	tst	r7, #(1 << 1)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	mov	r1, #(1 << COL8_PORT)
	tst	r7, #(1 << 0)
	streq	r1, [r0, #GPCLR0]
	strne	r1, [r0, #GPSET0]
	@ 行
	mov	r1, #(1 << ROW1_PORT)
	cmp	r6, #0
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW2_PORT)
	cmp	r6, #1
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW3_PORT)
	cmp	r6, #2
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW4_PORT)
	cmp	r6, #3
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW5_PORT)
	cmp	r6, #4
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW6_PORT)
	cmp	r6, #5
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW7_PORT)
	cmp	r6, #6
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]
	mov	r1, #(1 << ROW8_PORT)
	cmp	r6, #7
	strne	r1, [r0, #GPSET0]
	streq	r1, [r0, #GPCLR0]

@ちょっと待つ
	ldr	r1, =WAIT
1:	subs	r1, r1, #1
	bne	1b
	
	add	r6, r6, #1
	b	oploop
opend:
	bx	r14
	
	.section .data
frame_buffer:
	.byte 0, 0, 0, 0, 0, 0, 0, 0
dot0:
	.byte 0x00, 0xe0, 0xa0, 0xa0, 0xa0, 0xe0, 0x00, 0x00
dot1:
	.byte 0x00, 0x40, 0xc0, 0x40, 0x40, 0xe0, 0x00, 0x00
dot2:
	.byte 0x00, 0xe0, 0x20, 0xe0, 0x80, 0xe0, 0x00, 0x00
dot3:
	.byte 0x00, 0xe0, 0x20, 0xe0, 0x20, 0xe0, 0x00, 0x00
dot4:
	.byte 0x00, 0xa0, 0xa0, 0xe0, 0x20, 0x20, 0x00, 0x00
dot5:
	.byte 0x00, 0xe0, 0x80, 0xe0, 0x20, 0xe0, 0x00, 0x00
dot6:
	.byte 0x00, 0xe0, 0x80, 0xe0, 0xa0, 0xe0, 0x00, 0x00
dot7:
	.byte 0x00, 0xe0, 0xa0, 0x20, 0x20, 0x20, 0x00, 0x00
dot8:
	.byte 0x00, 0xe0, 0xa0, 0xe0, 0xa0, 0xe0, 0x00, 0x00
dot9:
	.byte 0x00, 0xe0, 0xa0, 0xe0, 0x20, 0xe0, 0x00, 0x00
