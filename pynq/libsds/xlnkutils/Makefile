ifeq "$(ARCH)" "arm64"
	AARCH_BIT := 64
	CC := aarch64-linux-gnu-gcc
else
	AARCH_BIT := 32
	CC := arm-linux-gnueabihf-gcc
endif


all: libsds_lib.so
.PHONY: all

libsds_lib.so:
	$(CC) wrapper.c -fPIC -shared -rdynamic -o libsds_lib.so -Wl,--whole-archive libsds_lib_$(AARCH_BIT).a -l pthread  -Wl,--no-whole-archive

clean:
	-rm -f *.so

install: libsds_lib.so
	cp -avf libsds_lib.so /usr/lib/
	cp -arvf libxlnk_cma.h /usr/include/
