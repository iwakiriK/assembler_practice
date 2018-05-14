	.section .text
	.global sort
sort:
	stmfd	sp!, {r0-r8, r14}
	
	mov	r2, #0		@ low
	sub	r3, r1, #1	@ high
	bl	quicksort

	ldmfd	sp!, {r0-r8, r14}
	bx	r14

quicksort:
	@ r0 start address, r1 num of words
	@ r2 low, r3, high
	str	r14, [sp, #-4]!	@ push r14
	cmp	r2, r3
	bge	return		@ if(low >= high)
	bl	partition
	@ r4 p
	add	r5, r4, #1	@ p + 1
	str	r5, [sp, #-4]!	@ push p+1
	str	r3, [sp, #-4]!	@ push high
	
	sub	r3, r4, #1	@ p - 1
	bl	quicksort
	ldr	r3, [sp], #4	@ pop high
	ldr	r2, [sp], #4	@ pop p + 1
	bl	quicksort
return:
	ldr	r14, [sp], #4	@ pop r14
	bx	r14
	
partition:
	str	r14, [sp, #-4]!	@ push r14
	sub	r4, r2, #1	@ i = low - 1
	ldr	r5, [r0, r3, lsl #2]	@ pivot
	mov	r6, r2		@ j
loop:
	cmp	r6, r3
	bge	break		@ if(j >= high)
	ldr	r7, [r0, r6, lsl #2]	@ A[j]
	cmp	r7, r5
	bcs	endSwap1	@ if(A[j] >= pivot)
	add	r4, r4, #1	@ i++
	ldr	r8, [r0, r4, lsl #2]	@ A[i]
	str	r8, [r0, r6, lsl #2]
	str	r7, [r0, r4, lsl #2]
endSwap1:
	add	r6, r6, #1	@ j++
	b	loop
break:
	add	r4, r4, #1	@ i++
	ldr	r8, [r0, r4, lsl #2]	@ A[i]
	str	r8, [r0, r3, lsl #2]
	str	r5, [r0, r4, lsl #2]

	ldr	r14, [sp], #4	@ pop r14
	bx	r14
