	; N(31<=N<2^20)以下の素数を大きい順に10個出力するプログラム
	
	section .text
	global  _start
	extern  print_eax	; 別のファイルラベル
_start:
	mov	esi, N		; Nからスタート
	mov	edi, 0		; 見つけた素数の数
	mov	ebx, esi

loop0:
	mov	ecx, 2		; 2以上N未満の整数d
loop1:
	mov	eax, ebx	; Nをeaxにコピー
	mov	edx, 0
	div	ecx		; N % dの剰余をedxに格納
	cmp	edx, 0		; 剰余が0のとき
	je	break		; breakへワープ
	inc	ecx		; d++
	cmp	ecx, ebx	; d >= Nのとき
	jge	else		; elseへワープ
	jmp 	loop1		; loop1へワープ
break:  jmp	endif
else:   inc	edi		; 見つけた素数の数をカウント
	mov	eax, ebx	; 見つけた素数をeaxにコピー
	call	print_eax 	; eaxの値を10進数で出力
endif:
	dec	ebx		; N--
	cmp	edi, 10		; 見つけた素数の数が10に満たない時
	jne	loop0		; loop0へワープ
	
	mov	eax, 1
	mov	ebx, 0
	int	0x80		; exit

	section .data
N:	equ	0xfffff		; 31 <= N < 2^20
