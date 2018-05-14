	.section .text
	.global _start
_start:
	mov	r0, #0		@ ans
	ldr	r1, =255	@ n
loop0:
	cmp	r1, #1
	bls	return		@ if(n <= 1)
	mov	r2, #2		@ j
loop1:
	cmp	r2, r1
	bge	break		@ if (j >= n)
	sdiv	r3, r1, r2	@ quotient
	mul	r4, r2, r3
	subs	r5, r1, r4	@ remainder
	beq	next		@ n % j == 0
	add	r2, r2, #1	@ j++
	b	loop1
break:
	add	r0, r0, #1	@ ans++
next:	
	sub	r1, r1, #1	@ n--
	b	loop0
return:	
	@ exit
	mov	r7, #1
	swi	#0
