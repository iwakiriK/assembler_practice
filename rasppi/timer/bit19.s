	.equ GPIO_BASE,0x3f200000   @ GPIOベースアドレス
	.equ GPFSEL0, 0x00   	    @ GPIOポートの機能を選択する番地のオフセット
	.equ GPSET0, 0x1C       @ GPIOポートの出力値を1にするための番地のオフセット
	.equ GPCLR0, 0x28       @ GPIOボートの出力値を0にするための番地のオフセット
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用
	.equ LED_PORT, 10		@ LED's port number
	.equ TIMER_BASE, 0x3f003000	@ TIMER BASE ADDRESS
	.equ TIMER_LOW, 0x4		@ TIMER COUNTER LOW OFFSET
	.equ TIMER_HIGH, 0x8		@ TIMER COUNTER HIGHT OFFSET
	
	.section .init
	.global _start
_start:
	ldr     r0, =GPIO_BASE            @ r0: GPIO_BASE に固定
	@ GPIO #10 を出力用に設定
	mov     r1, #(GPFSEL_OUT << (3 * (LED_PORT % 10)))
	str     r1, [r0, #(GPFSEL0 + LED_PORT / 10 * 4)]

	@ ループ前の準備 (r0, r1を設定する)
	mov     r1, #(1 << LED_PORT)      @ r1: LED のポートを制御するビット
	ldr	r10, =TIMER_BASE
loop:
	ldr	r11, [r10, #TIMER_LOW]	@ TIMERの下位32ビットをr11に読み出し
	@ ここでtimerCounterの上位32bitを読み出す場合はオフセットを(#TIMER_HIGH)に変える
	
	@ フリーランニングカウンタのbit 19に応じて点灯または消灯
	tst     r11, #(1 << 19)            @ bit 19 をテスト
	strne   r1, [r0, #GPSET0]         @   1 であれば LED 点灯
	streq   r1, [r0, #GPCLR0]         @   0 であれば LED 消灯
	
	b	 loop 
