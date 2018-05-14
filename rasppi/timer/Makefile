AS = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-as
LD = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-ld
LDFLAGS = -m armelf -no-undefined
COPY = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy

TESTS = bit19.img count10sec.img stopwatch.img
FILES = *~ *.o *.elf *.img

%.elf: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: test $(TESTS) clean
test: $(TESTS)

bit19.img: bit19.elf
	$(COPY) $< -O binary $@

count10sec.img: count10sec.elf
	$(COPY) $< -O binary $@

stopwatch.img: stopwatch.elf
	$(COPY) $< -O binary $@

clean:
	rm -f $(FILES)

# $@ ターゲット名
# $+ ソースファイルの列全体
# $< ソースファイル列の先頭1ファイル
