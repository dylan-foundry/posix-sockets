MELANGE=melange

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  PLATFORM_CFLAGS=-D_DARWIN_C_SOURCE
endif
ifeq ($(UNAME), Linux)
  PLATFORM_CFLAGS=
endif
ifeq ($(UNAME), FreeBSD)
  PLATFORM_CFLAGS=
endif

raw-posix-sockets.dylan: raw-posix-sockets.intr
	$(MELANGE) -Tc-ffi \
	           $(PLATFORM_CFLAGS) \
	           -m module-raw-posix-sockets.dylan \
	           raw-posix-sockets.intr \
	           raw-posix-sockets.dylan
