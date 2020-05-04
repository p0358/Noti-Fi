ARCHS = arm64 armv7
OS := $(shell uname)
ifeq ($(OS),Darwin)
  ARCHS += arm64e
endif
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiFi
NotiFi_FILES = $(wildcard *.xm) $(wildcard *.m)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
