	.section .text
	.global _start
_start:
	mov	r7, #1
	mov	r0, #0		@ isPrime
	ldr	r1, =12379	@ x
	cmp	r1, #2
	movcc	r0, #1		@ if(x < 2)
	mov	r2, r7, lsl #16	@ 65536
	cmp	r1, r2
	movcc	r2, r1		@ if(x < r2)

	mov	r5, #2		@ i
loop:
	cmp	r5, r2
	bpl	break		@ if(i >= goal)
	udiv	r3, r1, r5
	mul	r4, r3, r5
	cmp	r1, r4		@ if(x % i == 0)
	moveq	r0, #1		@ isNotPrime
	add	r5, r5, #1
	b	loop
break:
	swi	#0
