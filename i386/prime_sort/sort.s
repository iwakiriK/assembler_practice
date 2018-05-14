	;; クイックソート
	section .txt
	global sort
sort:
	push	eax
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi

	;; ebx.開始番地 ecx.個数
	mov	eax, 0		; left
	dec	ecx		; right

quick:
	mov	[left], eax	; leftを更新
	mov	[right], ecx	; rightを更新
	mov	edx, [left]	; pivot = left
	add	edx, [right]	; pivot += right
	shr	edx, 1		; pivot /= 2
	mov	edx, [ebx + edx * 4]
whilel:
	cmp	[ebx + eax * 4], edx ; if (x[i] < pivot)
	jnl	whiler		     ; falseならwhilerへ
	inc	eax		     ; i++
	jmp	whilel
whiler:
	cmp	edx, [ebx + ecx * 4] ; if (pivot < x[j])
	jnl	if		     ; falseならifへ
	dec	ecx		     ; j--
	jmp	whiler

if:
	cmp	eax, ecx	; if (i >= j)
	jge	break		; trueならbreakへ

swap:
	mov	edi, [ebx + eax * 4] ; swap開始
	mov	esi, [ebx + ecx * 4]
	mov	[ebx + eax * 4], esi 
	mov	[ebx + ecx * 4], edi ; swapおしまい
	inc	eax		     ; i++
	dec	ecx		     ; j--
	jmp	whilel
break:
	inc	ecx
	push	ecx		; j+1を格納
	mov	esi, [right]
	push	esi		; rightを格納
	dec	eax
	cmp	[left], eax	; if(left < i - 1)
	jnl	next		; falseならnextへ

	mov	ecx, eax
	mov	eax, [left]
	mov	edi, 1
	add	[count], edi
	call	quick
	mov	edi, 1
	sub	[count], edi
next:
	pop	esi		; right復活
	pop	ecx		; j+1復活
	cmp	ecx, esi	; if(j + 1 < right)
	jnl	end		; falseならおわり
	mov	eax, ecx
	mov	ecx, esi
	mov	edi, 1
	add	[count], edi
	call	quick
	mov	edi, 1
	sub	[count], edi
end:
	mov	edi, 0
	cmp	[count], edi
	jne	return

	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret

return:	ret

	section .data
left:	dd	0
right:	dd	0
count:	dd	0
