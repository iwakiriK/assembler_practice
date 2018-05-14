AS = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-as
LD = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-ld
LDFLAGS = -m armelf -no-undefined
COPY = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy

TESTS = 23.img uzu.img count.img
FILES = *~ *.o *.elf *.img

%.elf: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: test $(TESTS) clean
test: $(TESTS)

23.img: 23.elf
	$(COPY) $< -O binary $@

uzu.img: uzu.elf
	$(COPY) $< -O binary $@

count.img: count.elf
	$(COPY) $< -O binary $@

clean:
	rm -f $(FILES)

# $@ ターゲット名
# $+ ソースファイルの列全体
# $< ソースファイル列の先頭1ファイル
