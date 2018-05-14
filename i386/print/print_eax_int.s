        section .text
        global  print_eax_int       ; 別ファイルから参照可能にする
print_eax_int:
	push	eax
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi

	;; 正負判定
	mov	edi, 0		; 正負判定フラグ
	sub	eax, 0
	jns	break
	mov	edi, 1
	not	eax
	inc	eax
	
break:
	;; 出力
	mov	ebx, 10		; 基数
	mov	ecx, buf + max	; 末尾の次の番地	
	mov	esi, 1		; 文字数(1は改行文字分)
loop0:
	mov	edx, 0		; 割る準備
	div 	ebx
	add 	edx, 48		; += '0'
	dec 	ecx		; 座標を合わせる
	mov	[ecx], dl	; そこに入れる
	inc 	esi		; 文字数
	cmp	eax, 0		; if(商 > 0)
	jg	loop0

	cmp	edi, 1
	jne	output
	dec	ecx
	mov	edx, '-'
	mov	[ecx], dl
	inc	esi

output:	
	mov	edx, esi	; 出力文字数
	
	mov	eax, 4
	mov	ebx, 1
	int	0x80		; write
	
	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret

	section .data
max:	equ	11		; 最大文字数(10文字＋符号)
buf:	times max db 0		; max分あける
	db	0x0a		; 改行	
        
