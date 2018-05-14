	;; 引数として渡された配列内を整列するサブルーチンsort
	;; ソートはバブルソートを用いている
	section .text
	global  sort

sort:
	push    ebp             ; ebpを退避
        mov     ebp, esp        ; この時点のespをebpにコピー
	push	ebx
        push    esi
        push    edi
	
	mov	eax, [ebp + 12]	; 配列の要素数
	cmp	eax, 1
	jle	break
	mov	ebx, [ebp + 16]	; 1要素の大きさ
	dec	eax
loop0:
	mov	edx, [ebp + 8]	; 配列の先頭番地
	mov	ecx, eax	; copy
loop1:
	mov	esi, [edx]
	mov	edi, [edx + ebx]
	cmp	esi, edi	; 配列の中身の数値を比較
	jng	endswap		; esi > ediの時swapする
	call	swap
endswap:	
	add	edx, ebx	; 次の番地へ
	dec	ecx
	jz	loop2		; 配列の末尾までソートしたらloop2へ
	jmp	loop1
loop2:
	dec	eax		; swap開始位置をずらす
	jz	break		; ソートが完了したらbreak
	jmp	loop0		
break:	
	pop     edi
        pop     esi
	pop	ebx
        pop     ebp
	ret

swap:
	push	eax		; レジスタを退避
	mov	eax, 0
sloop:
	add	edx, eax
	mov	esi, [edx]
	mov	edi, [edx + ebx]
	mov	[edx], edi
	mov	[edx + ebx], esi
	sub	edx, eax
	add	eax, 4
	cmp	eax, ebx	; 要素全体のswapが完了したらswap終了
	jl	sloop
	
	pop	eax
	ret
