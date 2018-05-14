# マクロ定義
AS = nasm -felf
LD = ld
LDFLAGS = -m elf_i386
CC = gcc
CFLAGS = -m32 -W -Wall
OBJS_PRIME = isPrime.o test_prime.o

#擬似ターゲット
.PHONY:	clean test

# test_prime
test_prime: $(OBJS_PRIME)
	$(CC) $(CFLAGS) $+ -o $@

# isPrime.o
isPrime.o: isPrime.s
	$(AS) $<

# test_prime.o
test_prime.o: test_prime.c
	$(CC) -c $(CFLAGS) $<

# 不要ファイル削除
clean:
	rm -f *.o *~ a.out test_prime
test:	test_prime
	./test_prime <test.in | diff - test.ans
