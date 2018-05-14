	.equ GPIO_BASE,  0x3f200000   @ GPIOベースアドレス
	.equ GPFSEL0,    0x00         @ GPIOポートの機能を選択する番地のオフセット
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用
	.equ GPSET0,     0x1C         @ GPIOポートの出力値を1にするための番地のオフセット
	.equ GPCLR0,     0x28         @ GPIOボートの出力値を0にするための番地のオフセット
	.equ LED_PORT,   10           @ LEDが接続されたGPIOのポート番号
	.equ WAIT,       2015         @ sqrt(0x1f0000 * 2)

	.section .init
	.global _start
_start:
	ldr	r0, =GPIO_BASE

	@ GPIO #10 を出力用に設定
	mov	r1, #(GPFSEL_OUT << (3 * (LED_PORT % 10)))
	str	r1, [r0, #(GPFSEL0 + LED_PORT / 10 * 4)]
	ldr	r2, =WAIT	@ 1の待ち時間
	mov	r3, #-1		@ 1の差分
	mov	r4, #0		@ 2の待ち時間
	mov	r5, #1		@ 2の差分
loop:
	@ LEDけす
	mov	r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPCLR0 + LED_PORT / 32 * 4)]

	@ 空ループ1
	mov	r1, r2
1:
	subs	r1, #1
	bpl	1b
	
	@ LEDつける
	mov	r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPSET0 + LED_PORT / 32 * 4)]

	@ 空ループ2
	mov	r1, r4
2:
	subs	r1, #1
	bpl	2b

	@ 差分更新
	add	r4, r4, r5
	adds	r2, r2, r3
	beq	update1
	cmp	r4, #0
	beq	update2
	
	b       loop

update1:
	mov	r3, #1
	mov	r5, #-1
	b	loop

update2:
	mov	r3, #-1
	mov	r5, #1
	b	loop
	
