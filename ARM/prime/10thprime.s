	.section .text
	.global _start
_start:
	ldr	r0, =255	@ n
	mov	r1, #10		@ num
loop0:
	mov	r7, r0, lsr #1	@ int i
loop1:	
	cmp	r7, #1
	beq	break1		@ if(i == 1)
	udiv	r2, r0, r7	@ quotient
	mul	r3, r7, r2
	subs	r4, r0, r3	@ remainder
	beq	next		@ if (n % i == 0)
	sub	r7, r7, #1	@ i++
	b	loop1
break1:
	subs	r1, r1, #1	@ num--
	beq	return		@ if(num == 0)
next:
	sub	r0, r0, #1	@ n--
	b	loop0
return:	
	@ exit
	swi	#0
