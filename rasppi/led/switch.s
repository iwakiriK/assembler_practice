	.equ GPIO_BASE,  0x3f200000   @ GPIOベースアドレス
	.equ GPFSEL0,    0x00         @ GPIOポートの機能を選択する番地のオフセット
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用
	.equ GPSET0,     0x1C         @ GPIOポートのを1にするための番地のオフセット
	.equ GPCLR0,     0x28         @ GPIOボートのを0にするための番地のオフセット
	.equ GPLEV0, 	 0x34	      @ GPIO Pin Level 0 のオフセット
	.equ LED_PORT,   10           @ LEDが接続されたGPIOのポート番号
	.equ SW1_PORT,   13	      @ switch1のポート番号
	
	.section .init
	.global _start
_start:
	ldr     r0, =GPIO_BASE

	@ GPIO #10 を出力用に設定
	mov     r1, #(GPFSEL_OUT << (3 * (LED_PORT % 10)))

	@ GPIO #13 setting input
	orr	r1, r1, #(GPFSEL_IN << (3 * (SW1_PORT % 10)))
	str     r1, [r0, #(GPFSEL0 + LED_PORT / 10 * 4)]
	
loop:	
	@ GPIO #13 をinputしたい
	ldr     r1, [r0, #GPLEV0]
	and	r1, #(1 << SW1_PORT)
	cmp	r1, #(1 << SW1_PORT)
	bne	turn_off

turn_on:
	@ GPIO #10 に 1 を出力
	mov     r1, #(1 << (LED_PORT % 32))
	str	r1, [r0, #(GPSET0 + LED_PORT / 32 * 4)]
	b	loop
	
turn_off:		
	@ GPIO #10 に 0 を出力
	mov     r1, #(1 << (LED_PORT % 32))
	str     r1, [r0, #(GPCLR0 + LED_PORT / 32 * 4)]
	b       loop
