		section .text
        global  print_eax_frac       ; 別ファイルから参照可能にする
print_eax_frac:
	push	eax
	push	ebx
	push	ecx
	push	edx
	push	esi
	push	edi

	call	examinSign	; 正負判定(負なら2の補数で正に変えediを1に)
	;; eaxの小数部をpushし,eaxを整数のみにする
	mov	ebx, eax
	shl	ebx, 8		; 整数部を消す
	shr	ebx, 8		; シフトを合わせる
	push	ebx		; 小数のみ格納
	shr	eax, 24		; 整数部のみにする
	call	outputInteger	; 整数部出力
	pop	eax		; 小数部取り出し
	push	eax
	call	outputPoint	; 小数点出力
	pop	eax
	call	outputDecimal	; 小数部出力
	call	outputEnter	; 改行出力
	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret

examinSign:	
	mov	edi, 0		; 正負判定フラグ
	sub	eax, 0
	jns	esbreak
	mov	edi, 1
	not	eax
	inc	eax
esbreak:
	ret
	

outputInteger:	
	mov	ebx, 10		; 基数
	mov	ecx, buf + max 	; 末尾の次の番地	
	mov	esi, 0		; 文字数
oiloop:
	mov	edx, 0		; 割る準備
	div 	ebx
	add 	edx, 48		; += '0'
	dec 	ecx		; 座標を合わせる
	mov	[ecx], dl	; そこに入れる
	inc 	esi		; 文字数
	cmp	eax, 0		; if(商 > 0)
	jg	oiloop
	cmp	edi, 1		; 負数ならマイナスも追加
	jne	oibreak
	dec	ecx
	mov	edx, '-'
	mov	[ecx], dl
	inc	esi
oibreak:	
	mov	edx, esi	; 出力文字数
	mov	eax, 4
	mov	ebx, 1
	int	0x80		; write
	ret

outputDecimal:
	;; eaxに小数部のみある
	mov	ebx, 10		; 基数
	mov	ecx, buf2
	mov	esi, 0		; 出力個数
odloop:
	mul	ebx
	mov	edx, eax
	shl	eax, 8
	shr	eax, 8		; 小数部のみ(次に割る値)
	shr	edx, 24		; 整数部のみ
	add	edx, '0'
	mov	[ecx], dl
	inc	ecx
	inc	esi
	cmp	eax, 0
	jne	odloop
	;; 出力
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, buf2
	mov	edx, esi
	int	0x80
	ret

outputEnter:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, enter
	mov	edx, 1
	int	0x80
	ret

outputPoint:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, point
	mov	edx, 1
	int	0x80
	ret

	section .data
max:	equ	11		; 最大文字数(10文字＋符号)
buf:	times max db 0		; max分あける
max2:	equ	24
buf2:	times max2 db 0
point:	db	'.'
enter:	db	0x0a		; 改行
        
