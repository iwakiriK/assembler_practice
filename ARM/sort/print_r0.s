	@ r0レジスタの値を10進数で標準出力するプログラム
	@ サブルーチンprint_r0を定義
	.section .text
	.global print_r0
	.equ	max, 10
	
print_r0:
	stmfd	sp!, {r0-r5, r7, r14}	@ push
	ldr	r1, =buf+max		@ address
	mov	r2, #1			@ count
loop:
	mov	r5, #10			@ radix
	udiv	r3, r0, r5		@ r3 = r0 / 10
	mul	r4, r5, r3		@ r4 = 10 * r3
	subs	r5, r0, r4 		@ r5 = r0 - r4
	add	r5, r5, #48 		@ += '0'
	sub	r1, r1, #1
	strb	r5, [r1]
	add	r2, r2, #1
	movs	r0, r3
	bne	loop			@ if(r0 != 0)
	@ write
	mov	r7, #4
	mov	r0, #1
	swi	#0
	
	ldmfd	sp!, {r0-r5, r7, r14}	@ pop
	bx	r14

	.section .data
buf:	.space	max
	.byte	0x0a		@ enter
	
