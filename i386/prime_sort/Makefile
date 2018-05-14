# マクロ定義
AS = nasm -felf
LD = ld
LDFLAGS = -m elf_i386
OBJS_PRINT = test_print.o print_eax.o
OBJS_PRIME = 10primes.o print_eax.o
OBJS_SORT = test_sort.o sort.o print_eax.o

# 型規制(.sから.oを生成)
%.o: %.s
	$(AS) $<

# 生成規則
all: test_print test_prime test_sort
test_print: $(OBJS_PRINT)
	$(LD) $(LDFLAGS) $+ -o $@
test_prime: $(OBJS_PRIME)
	$(LD) $(LDFLAGS) $+ -o $@
test_sort: $(OBJS_SORT)
	$(LD) $(LDFLAGS) $+ -o $@
# 擬似ターゲット
.PHONY: clean test
# 不要なファイルを削除
clean:
	rm -f *.o *~ a.out test_print test_prime test_sort
test: test_print answer_print.txt test_prime answer_prime.txt test_sort answer_sort.txt
	./test_print | diff - answer_print.txt
	./test_prime | diff - answer_prime.txt
	./test_sort | diff - answer_sort.txt
