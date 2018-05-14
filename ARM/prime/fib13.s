	@ フィボナッチ数列におけるn=13のときのf13の値を求める
	@ 漸化式 f0 = 0, f1 = 1, fn = fn-1 + fn-2 (n>=2) で定義
	@ r1 = fn-1, r0 = fn, r2 = n, r3 = fn+1
	.section .text
	.global  _start
	.equ	X, 13
_start:
	@ write
	mov	r0, #0x00010000		@ f_(n-1), f_(n-2)
	mov	r7, #3-2*X
loop:
	add	r0, r0, r0, lsr #16 	@ f_(n-2) += f_(n-1)
	mov	r0, r0, ror #16		@ swap
	adds	r7, r7, #2		@ r7 += 2
	bmi	loop
	@ exit
	mov	r0, r0, lsr #16		@ r0 = f_(n-2)
	swi	#0			@ システムコールの発行
