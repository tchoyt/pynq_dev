ifeq "$(ARCH)" "arm64"
	AARCH_BIT := 64
else
	AARCH_BIT := 32
endif

all: libsds_lib.so
.PHONY: all

libsds_lib.so:
	$(CROSS_COMPILE)gcc wrapper.c -fPIC -shared -rdynamic -o libsds_lib.so -Wl,--whole-archive libsds_lib_$(AARCH_BIT).a -l pthread  -Wl,--no-whole-archive

clean:
	-rm -f *.so
