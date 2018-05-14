	section	.text
	global	isPrime

;;; int isPrime(unsigned int x);
;;; @return 1 if x is a prime number; 0 otherwise.
isPrime:
	;; push
	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi
	;; O(1)
	mov	esi, [ebp + 8]
	cmp	esi, 2		; x < 2
	jb	isNotPrime	; not prime
	cmp	esi, 2		; x == 2
	je	break		; prime
	mov	eax, esi
	mov	ebx, 2
	mov	edx, 0
	div	ebx
	cmp	edx, 0		; x % 2 == 0
	je	isNotPrime	; not prime
	;; sieve 
	call	getSquareRoot	; sqrt put in ecx
	mov	ebx, 3		; divisor
loop0:
	cmp	ebx, ecx	; i > sqrt(x)
	ja	break		; not found(prime)
	mov	eax, esi
	mov	edx, 0
	div	ebx
	cmp	edx, 0
	je	isNotPrime
	add	ebx, 2		; i += 2
	jmp	loop0
break:	
	mov	eax, 1
	jmp	return
isNotPrime:
	mov	eax, 0
	jmp	return
return:	
	;; pop
	pop	edi
	pop	esi
	pop	ebx
	pop	ebp
	ret

getSquareRoot:
	cmp	esi, 4294836225	; sqrt(x) >= 65535
	jae	gsBig		; sqrt(x) == 65535
	mov	ecx, 1
gsloop:
	mov	eax, ecx
	mul	eax
	cmp	eax, esi	; i * i >= x
	jae	gsbreak		; break
	inc	ecx		; i += 2
	jmp	gsloop
gsBig:
	mov	ecx, 65535
gsbreak:	
	ret
