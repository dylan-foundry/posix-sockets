MELANGE=melange

raw-posix-sockets.dylan: raw-posix-sockets.intr
	$(MELANGE) -Tc-ffi \
	           -m module-raw-posix-sockets.dylan \
	           raw-posix-sockets.intr \
	           raw-posix-sockets.dylan
