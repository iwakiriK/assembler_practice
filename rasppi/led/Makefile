AS = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-as
LD = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-ld
LDFLAGS = -m armelf -no-undefined
COPY = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy

TESTS = light.img alignment.img blink.img myblink.img switch.img swled.img
FILES = *~ *.o *.elf *.img

%.elf: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: test $(TESTS) clean
test: $(TESTS)

light.img: light.elf
	$(COPY) $< -O binary $@

alignment.img: alignment.elf
	$(COPY) $< -O binary $@

blink.img: blink.elf
	$(COPY) $< -O binary $@

myblink.img: myblink.elf
	$(COPY) $< -O binary $@

switch.img: switch.elf
	$(COPY) $< -O binary $@

swled.img: swled.elf
	$(COPY) $< -O binary $@

clean:
	rm -f $(FILES)

# $@ ターゲット名
# $+ ソースファイルの列全体
# $< ソースファイル列の先頭1ファイル
