arm-vita-eabi.gcc := $(shell which arm-vita-eabi-gcc 2> /dev/null)

ifeq ($(arm-vita-eabi-gcc),)
  arm-vita-eabi-gcc := docker run --platform linux/amd64 -v "$(CURDIR):/test" --user "$(shell id -u):$(shell id -g)" -w /test --rm vitasdk/vitasdk arm-vita-eabi-gcc
endif


build:
	clang --target=armv7-none-eabi -mthumb -c start.s -o start.o
	clang --target=armv7-none-eabi -mthumb -c func_thumb.c -o func_thumb.o
	clang -O2 --target=armv7-none-eabi -marm -c func_arm.c -o func_arm.o
	clang --target=armv7-none-eabi  -Wl,-Ttext,0x81000000 -o result_lld -nostdlib start.o func_thumb.o func_arm.o
	$(arm-vita-eabi-gcc) -nostdlib -o result_vitasdk func_thumb.o func_arm.o start.o
.PHONY: build

dump: build
	llvm-objdump -d result_lld
	llvm-objdump -d result_vitasdk
.PHONY: dump
