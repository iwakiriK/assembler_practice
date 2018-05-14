	.section .text
	.global  _start
	.equ	N, 100
	.equ	max, 7		@ num of digits
_start:
	mov	r7, #1
	ldr	r3, =sieve	@ address of sieve
	ldr	r4, =N
	mov	r5, #2		@ i
loop0:
	cmp	r5, r4
	bhi	return		@ if(i > N)
	ldrb	r6, [r3, r5]
	cmp	r6, #1
	beq	next		@ if(sieve[i] == 1)
	@ ********** output **********
	ldr	r1, =buf+max	@ address
	mov	r2, #1		@ count
	mov	r6, r5
	mov	r7, #10		@ radix
oloop:
	udiv	r8, r6, r7	@ prime / 10
	mul	r9, r7, r8
	subs	r9, r6, r9	@ prime % 10
	add	r9, r9, #48	@ += '0'
	sub	r1, r1, #1
	strb	r9, [r1]
	add	r2, r2, #1
	movs	r6, r8
	bne	oloop		@ if(r0 != 0)
write:
	mov	r7, #4
	mov	r0, #1
	swi	#0
	mov	r7, #1
	@ ********** output **********
	add	r6, r5, r5	@ j
loop1:
	cmp	r6, r4
	bhi	next		@ if(j > n)
	strb	r7, [r3, r6]
	add	r6, r6, r5	@ j += i
	b	loop1
next:
	add	r5, r5, #1	@ i += 2
	b	loop0
return:
	mov	r0, #0
	swi	#0

	.section .data
sieve:	.space	N+1, 0
buf:	.space	max
	.byte	0x0a		@ enter
