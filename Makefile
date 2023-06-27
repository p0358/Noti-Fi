TARGET = iphone:12.2:12.2
ARCHS = arm64 arm64e
PREFIX="/Library/Developer/TheosToolchains/Xcode11.xctoolchain/usr/bin/"

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiFi
NotiFi_FILES = $(wildcard *.xm) $(wildcard *.m)

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
