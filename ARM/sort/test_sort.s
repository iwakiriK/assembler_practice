	.section .text
	.global  _start
_start:
	ldr	r0, =data	@ データの先頭番地
	ldr	r1, =ndata	@ ワードの個数
	bl	sort		@ 昇順に整列

	ldr	r3, =data
	mov	r2, #0
loop:
	cmp	r2, r1
	beq	return
	ldr	r0, [r3, r2, lsl #2]
	bl	print_r0
	add	r2, r2, #1
	b	loop
return:	
	mov	r7, #1
	mov	r0, #0
	swi	#0	@ exit

	.section .data
data:	.word	3, 1, 4, 1, 5, 9
	.word	2, 6, 5, 3, 5, 8
	.equ	ndata, (. - data)/4	@ ワードの個数(=バイト数/4)
