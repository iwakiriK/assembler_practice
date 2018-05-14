	.equ GPIO_BASE,  0x3f200000   @ GPIOベースアドレス
	.equ GPFSEL0,    0x00         @ GPIOポートの機能を選択する番地のオフセット
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用
	.equ GPSET0,     0x1C         @ GPIOポートのを1にするための番地のオフセット
	.equ GPCLR0,     0x28         @ GPIOボートのを0にするための番地のオフセット
	.equ GPLEV0, 	 0x34	      @ GPIO Pin Level 0 のオフセット
	.equ LED_PORT,   10           @ LEDが接続されたGPIOのポート番号
	.equ SW1_PORT,   13	      @ switch1のポート番号
	.equ SW2_PORT,   26           @ switch2のポート番号
	.equ WAIT,       2015         @ sqrt(0x1f0000 * 2)

	.section .init
	.global _start
_start:
	ldr     r0, =GPIO_BASE

	@ GPIO #10 を出力用に設定
	mov     r1, #(GPFSEL_OUT << (3 * (LED_PORT % 10)))

	@ GPIO #13 setting input
	orr	r1, r1, #(GPFSEL_IN << (3 * (SW1_PORT % 10)))
	orr	r1, r1, #(GPFSEL_IN << (3 * (SW2_PORT % 10)))
	str     r1, [r0, #(GPFSEL0 + LED_PORT / 10 * 4)]

	ldr	r2, =WAIT	@ 消灯時間
	mov	r3, #0		@ 点灯時間

loop:
SW1:	
	@ SW1押してるかどうか(押すと光が強くなる)
	ldr     r1, [r0, #GPLEV0]
	and	r1, #(1 << SW1_PORT)
	cmp	r1, #(1 << SW1_PORT)
	bne	SW2
	@ SW1押してる
	cmp	r2, #0
	beq	SW2		@ 明るさMAXなら無視
	sub	r2, r2, #1
	add	r3, r3, #1
SW2:
	@ SW2押してるかどうか(押すと光が弱くなる)
	ldr     r1, [r0, #GPLEV0]
	and	r1, #(1 << SW2_PORT)
	cmp	r1, #(1 << SW2_PORT)
	bne	run
	@ SW2押してる
	cmp	r3, #0
	beq	run		@ 明るさ0なら無視
	add	r2, r2, #1
	sub	r3, r3, #1
run:
	@ LEDを消す
	mov     r1, #(1 << (LED_PORT % 32))
	str     r1, [r0, #(GPCLR0 + LED_PORT / 32 * 4)]
	@ 空ループ1
	mov	r1, r2
wait1:	
	subs	r1, #1
	bpl	wait1
	@ LEDを付ける
	mov     r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPSET0 + LED_PORT / 32 * 4)]
	@ 空ループ2
	mov	r1, r3
wait2:
	subs	r1, #1
	bpl	wait2
	
	b       loop
