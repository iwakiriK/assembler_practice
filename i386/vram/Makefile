# マクロ定義
AS = nasm -felf -fbin
OBJS_VRAM = vram.s

# vram作成
vram: $(OBJS_VRAM)
	$(AS) $<

# 不要ファイル削除
clean:
	rm -f *.o *~ a.out vram
