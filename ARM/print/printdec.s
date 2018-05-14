	.section .text
	.global  _start
	.equ	N, 123
	.equ	max, 10		@ num of digits
_start:
	ldr	r0, =N
	ldr	r1, =buf+max	@ address
	mov	r2, #1		@ count
	mov	r6, #10		@ radix
loop:
	udiv	r3, r0, r6	@ r3 = r0 / 10
	mul	r4, r6, r3	@ r4 = 10 * r3
	subs	r5, r0, r4	@ r5 = r0 - r4
	add	r5, r5, #48	@ += '0'
	sub	r1, r1, #1
	strb	r5, [r1]
	add	r2, r2, #1
	movs	r0, r3
	bne	loop		@ if(r0 != 0)
write:
	mov	r7, #4
	mov	r0, #1
	swi	#0
exit:	
	mov	r7, #1		@ exitシステムコール番号
	swi	#0		@ システムコールの発行

	.section .data
buf:	.space	max
	.byte	0x0a		@ enter
