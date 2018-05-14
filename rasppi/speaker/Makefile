AS = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-as
LD = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-ld
LDFLAGS = -m armelf -no-undefined
COPY = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy

TESTS = ra.img doremi.img jiho.img music.img
FILES = *~ *.o *.elf *.img

%.elf: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: test $(TESTS) clean
test: $(TESTS)

ra.img: ra.elf
	$(COPY) $< -O binary $@

doremi.img: doremi.elf
	$(COPY) $< -O binary $@

jiho.img: jiho.elf
	$(COPY) $< -O binary $@

music.img: music.elf
	$(COPY) $< -O binary $@

clean:
	rm -f $(FILES)

# $@ ターゲット名
# $+ ソースファイルの列全体
# $< ソースファイル列の先頭1ファイル
