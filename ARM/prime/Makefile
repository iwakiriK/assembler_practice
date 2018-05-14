AS = arm-linux-gnu-as
LD = arm-linux-gnu-ld
LDFLAGS = -m armelf_linux_eabi

# 擬似ターゲット
.PHONY: copy-fib13 copy-isprime copy-nprime255 copy-10thprime clean

# 生成規則
fib13: fib13.o
	$(LD) $(LDFLAGS) $< -o $@
isprime: isprime.o
	$(LD) $(LDFLAGS) $< -o $@
nprime255: nprime255.o
	$(LD) $(LDFLAGS) $< -o $@
10thprime: 10thprime.o
	$(LD) $(LDFLAGS) $< -o $@

# 型規制(.sから.oを生成)
%.o: %.s
	$(AS) $< -o $@

copy-fib13: fib13
	scp $< 172.28.28.172:
copy-isprime: isprime
	scp $< 172.28.28.172:
copy-nprime255: nprime255
	scp $< 172.28.28.172:
copy-10thprime: 10thprime
	scp $< 172.28.28.172:

# 不要ファイル削除
clean:
	rm -f *.o *~ a.out fib13 isprime nprime255 10thprime
