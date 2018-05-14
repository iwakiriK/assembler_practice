AS = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-as
LD = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-ld
LDFLAGS = -m armelf -no-undefined
COPY = /opt/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy

TESTS = main.img music.img switch.img led.img screen.img sandstorm.img basilisk.img monhan.s RageOfDust.s
LINKFILES = main.o music.o switch.o led.o screen.o sandstorm.o basilisk.o monhan.o RageOfDust.o
FILES = *~ *.o *.elf *.img

%.elf: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: $(TESTS) clean
main.img: main.o music.o screen.o
	$(LD) $(LDFLAGS) $+ -o main.elf
	$(COPY) main.elf -O binary $@

music.img: music.elf
	$(COPY) $< -O binary $@

switch.img: switch.elf
	$(COPY) $< -O binary $@

led.img: led.elf
	$(COPY) $< -O binary $@

screen.img: screen.elf
	$(COPY) $< -O binary $@
sandstorm.img: sandstorm.elf
	$(COPY) $< -O binary $@
basilisk.img: basilisk.elf
	$(COPY) $< -O binary $@
monhan.img: monhan.elf
	$(COPY) $< -O binary $@
RageOfDust.img: RageOfDust.elf
	$(COPY) $< -O binary $@
clean:
	rm -f $(FILES)

# $@ ターゲット名
# $+ ソースファイルの列全体
# $< ソースファイル列の先頭1ファイル
