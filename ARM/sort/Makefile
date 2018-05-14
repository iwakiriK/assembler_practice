AS = arm-linux-gnu-as
LD = arm-linux-gnu-ld
LDFLAGS = -m armelf_linux_eabi

# 擬似ターゲット
.PHONY: copy-call copy-print_r0 copy-10primes copy-sort copy-nprimes clean

# 生成規則
call: call.o
	$(LD) $(LDFLAGS) $< -o $@
print_r0: print_r0.o test_print_r0.o
	$(LD) $(LDFLAGS) $^ -o $@
10primes: 10primes.o print_r0.o
	$(LD) $(LDFLAGS) $^ -o $@
sort: sort.o test_sort.o print_r0.o
	$(LD) $(LDFLAGS) $^ -o $@
nprimes: nprimes.o print_r0.o
	$(LD) $(LDFLAGS) $^ -o $@


# 型規制(.sから.oを生成)
%.o: %.s
	$(AS) $< -o $@

copy-call: call
	scp $< 172.28.28.172:
copy-print_r0: print_r0
	scp $< 172.28.28.172:
copy-10primes: 10primes
	scp $< 172.28.28.172:
copy-sort: sort
	scp $< 172.28.28.172:
copy-nprimes: nprimes
	scp $< 172.28.28.172:
# 不要ファイル削除
clean:
	rm -f *.o *~ a.out call print_r0 10primes sort nprimes
