	@ N(0 <= N < 2^32)の値を16進数で標準出力するプログラム
	.section .text
	.global  _start
	.equ	N, 4294967294
	.equ	max, 8		@ num of digits
_start:
	ldr	r0, =N
	ldr	r1, =buf+max	@ address
	mov	r2, #max	@ count
loop:
	lsr	r3, r0, #4	@ r3 = r0 / 16
	lsl	r4, r3, #4	@ r4 = r3 * 16
	sub	r5, r0, r4	@ r5 = r0 - r4
	cmp	r5, #10		@ r5 >= 10のとき
	addcs	r5, r5, #87	@ a~fに対応
	addcc	r5, r5, #48	@ += '0'
	sub	r1, r1, #1	@ r1--
	strb	r5, [r1]
	mov	r0, r3
	subs	r2, r2, #1	@ r2--
	bne	loop		@ if(r2 != 0)
	@ write
	mov	r7, #4
	mov	r0, #1
	mov	r2, #max + 1
	swi	#0
	@ exit	
	mov	r7, #1		@ exitシステムコール番号
	swi	#0		@ システムコールの発行

	.section .data
buf:	.space	max
	.byte	0x0a		@ enter
