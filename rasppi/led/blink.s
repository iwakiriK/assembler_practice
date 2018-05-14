	.equ GPIO_BASE,  0x3f200000   @ GPIOベースアドレス
	.equ GPFSEL0,    0x00         @ GPIOポートの機能を選択する番地のオフセット
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用
	.equ GPSET0,     0x1C         @ GPIOポートの出力値を1にするための番地のオフセット
	.equ GPCLR0,     0x28         @ GPIOボートの出力値を0にするための番地のオフセット
	.equ LED_PORT,   10           @ LEDが接続されたGPIOのポート番号
	.equ WAIT,       0x1f0000     @ 待機時間(0.5秒ぐらい)

	.section .init
	.global _start
_start:
	ldr	r0, =GPIO_BASE

	@ GPIO #10 を出力用に設定
	mov	r1, #(GPFSEL_OUT << (3 * (LED_PORT % 10)))
	str	r1, [r0, #(GPFSEL0 + LED_PORT / 10 * 4)]
loop:
	@ GPIO #10 に 1 を出力
	mov	r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPSET0 + LED_PORT / 32 * 4)]

	@ 空ループ1
	mov	r1, #WAIT
1:	subs	r1, r1, #1	@ 何もしないまま 0x1f0000 から 0 までカウントダウン
        bne	1b

	@ 0に
	mov	r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPCLR0 + LED_PORT / 32 * 4)]

	@ 空ループ2
	mov	r1, #WAIT
2:	subs	r1, r1, #1	@ 何もしないまま 0x1f0000 から 0 までカウントダウン
        bne	2b

	b       loop
