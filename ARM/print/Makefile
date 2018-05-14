AS = arm-linux-gnu-as
LD = arm-linux-gnu-ld
LDFLAGS = -m armelf_linux_eabi

# 擬似ターゲット
.PHONY: copy-printdec copy-printhex copy-primes copy-123 clean

# 生成規則
printdec: printdec.o
	$(LD) $(LDFLAGS) $< -o $@
printhex: printhex.o
	$(LD) $(LDFLAGS) $< -o $@
primes: primes.o
	$(LD) $(LDFLAGS) $< -o $@
123: 123.o
	$(LD) $(LDFLAGS) $< -o $@


# 型規制(.sから.oを生成)
%.o: %.s
	$(AS) $< -o $@

copy-printdec: printdec
	scp $< 172.28.28.172:
copy-printhex: printhex
	scp $< 172.28.28.172:
copy-primes: primes
	scp $< 172.28.28.172:
copy-123: 123
	scp $< 172.28.28.172:

# 不要ファイル削除
clean:
	rm -f *.o *~ a.out printdec printhex primes
