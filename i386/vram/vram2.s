; 下記に掲載のプログラムを基に作成した:
; http://d.hatena.ne.jp/rudeboyjet/20080108/p1
; テキストVRAMの使い方は下記を参照:
; https://en.wikipedia.org/wiki/VGA-compatible_text_mode

	; ブートストラップコードは Real-address mode で実行されるので,
	; 32ビットの番地を指定しても下位16ビットのみ使用される.

	; AX, CX, DXは番地の指定に使えない (EAX, ECX, EDXは使える).

	org	0x7c00		; 開始番地

	mov	ax, 0xb800	; VRAMの開始番地 (÷ 16)
	mov	ds, ax		; セグメントレジスタにVRAMの番地を代入

loop:
	call	drawBackground	; 背景を塗る
	call	drawCharacter	; キャラクターを塗る
	call	doNothing	; 空ループ
	call	updateDiff	; 差分更新
	jmp	loop
	
	hlt			; HALT (CPUを停止)


drawBackground:	
	mov	al, 219		; マス全部塗り潰す文字
	mov	cx, 2000	; ループ回数(画面サイズ)
	mov	bx, 0		; 座標
	mov	ah, 0x7f	; 白色
bloop:
	mov	[bx], ax
	add	bx, 2		; 次のマスへ
	dec	cx
	jnz	bloop
	ret

drawCharacter:	
	mov	di, 0		; 色インデックス
	mov	si, 0		; 座標インデックス
value:	
	mov	cl, [cs:num+di]	; ループ回数
	mov	ah, [cs:tcolor+di] ; 文字色
dloop:	
	mov	dx, [cs:color+si]
	add	dx, [cs:move]	; アニメーション用の差分
	shl	dx, 1		; 座標を合わせる
	mov	bx, dx
	mov	[bx], ax
	mov	[bx+2], ax	; ドットを正方形に
	add	si, 2		; 次の座標へ
	dec	cl
	jnz	dloop
	inc	di		; 次の色
	cmp	di, 3
	jne	value		; 色を全て使えば終了
	mov	ah, 0x1a	; 弾の色(青)
	mov	al, 15
	mov	bx, [cs:blt1]
	mov	[bx], ax	; 弾1を塗る
	mov	bx, [cs:blt2]
	mov	[bx], ax	; 弾2を塗る
	ret

doNothing:	
	mov	ebx, 0x500000	; 待ち時間
wloop:
	dec	ebx
	jnz	wloop
	ret

updateDiff:	
	cmp	word[cs:move], 20 ; 中心から右に10動いていたら
	jne	right
	mov	word[cs:dmove], -2 ; 動きを左向きに
	mov	word[cs:blt2], 120 ; 弾2を初期座標に
right:
	cmp	word[cs:move], -20 ; 中心から左に10動いていたら
	jne	break
	mov	word[cs:dmove], 2 ; 動きを右向きに
	mov	word[cs:blt1], 34 ; 弾1を初期座標に
break:
	mov	si, [cs:dmove]
	add	word[cs:move], si ; 差分を更新
	add	word[cs:blt1], 160
	add	word[cs:blt2], 160
	ret
	
color:	
black:	dw	 586,  588,  590,  592,  594,  596,  600,  602,  604,  606
	dw	 608,  610,  664,  674,  678,  682,  692,  744,  750,  766
	dw	 772,  824,  828,  848,  852,  906,  930,  986, 1010, 1068
	dw	1074, 1082, 1088, 1146, 1154, 1162, 1168, 1224, 1226, 1228
	dw	1232, 1244, 1250, 1304, 1312, 1314, 1316, 1320, 1322, 1330
	dw	1384, 1390, 1394, 1398, 1402, 1406, 1408, 1410, 1466, 1472
	dw	1476, 1480, 1484, 1492, 1548, 1550, 1566, 1572, 1628, 1648
	dw	1650, 1710, 1726, 1792, 1796, 1798, 1800, 1804
brown:	dw	 676,  680,  752,  754,  756,  758,  760,  762,  764,  830
	dw	 832,  834,  836,  838,  840,  842,  844,  846,  908,  910
	dw	 912,  914,  916,  920,  922,  924,  926,  928,  988,  990
	dw	 992,  996, 1000, 1004, 1006, 1008, 1070, 1086, 1148, 1248
	dw	1310, 1324, 1326, 1328
red:	dw	 598,  668,  670,  672,  684,  686,  688,  748,  768, 1150
	dw	1166, 1230, 1246, 1306, 1386, 1468, 1474, 1482, 1490, 1552
	dw	1554, 1556, 1558, 1560, 1562, 1564, 1570, 1632, 1634, 1636
	dw	1638, 1640, 1642, 1644, 1716, 1720, 1794, 1802

num:	db	  78,   44,   38 ; 黒，茶，赤の数
tcolor:	db	0x00, 0x66, 0x44 ; ahに使う文字背景色
move:	dw	0		; アニメーション用差分
dmove:	dw	2		; moveの加減用
blt1:	dw	34		; 弾1の座標
blt2:	dw	-1600		; 弾2の座標

	times	510-($-$$) db 0	; セクタ末尾まで0で埋める ($$は開始番地)
	db	0x55, 0xaa	; Boot Signature
