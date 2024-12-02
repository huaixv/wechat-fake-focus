# Compiler and flags
CC = gcc
CFLAGS = -fPIC -shared -Wall
LIBS = -ldl -lX11

# Output libraries
TARGET_64 = libxsetinputfocus_64.so
TARGET_32 = libxsetinputfocus_32.so

INSTALL_LIB_PATH = /opt/apps/com.qq.weixin.deepin/files/lib32/
INSTALL_SCRIPT_PATH = /opt/apps/com.qq.weixin.deepin/files/run.sh

# Source file
SRC = preload.c

# Build rules
all: $(TARGET_64) $(TARGET_32)

$(TARGET_64): $(SRC)
	$(CC) $(CFLAGS) -m64 -o $@ $< $(LIBS)

$(TARGET_32): $(SRC)
	$(CC) $(CFLAGS) -m32 -o $@ $< $(LIBS)

install: $(TARGET_32)
	mkdir -p $(INSTALL_LIB_PATH)
	cp $(TARGET_32) $(INSTALL_LIB_PATH)
	sed -i '/export LD_LIBRARY_PATH/a export LD_PRELOAD=/opt/apps/$$DEB_PACKAGE_NAME/files/lib32/$(TARGET_32)' $(INSTALL_SCRIPT_PATH)

script:
	echo '#!/bin/bash' > run_with_preloads.sh
	echo 'LD_PRELOAD=$$PWD/$(TARGET_64):$$PWD/$(TARGET_32) exec "$$@"' >> run_with_preloads.sh
	chmod +x run_with_preloads.sh

clean:
	rm -f $(TARGET_64) $(TARGET_32) run_with_preloads.sh

