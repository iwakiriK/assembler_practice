	.section .text
	.global _start
_start:
	ldr	r0, =123456
	bl	print_r0
	@ exit
	mov	r7, #1
	swi	#0
