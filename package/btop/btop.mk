################################################################################
#
# btop
#
################################################################################

BTOP_VERSION = 1.4.6
BTOP_SOURCE = btop-arm-unknown-linux-musleabi.tbz
#BTOP_SOURCE = btop-aarch64-unknown-linux-musl.tbz
#BTOP_SOURCE = btop-x86_64-unknown-linux-musl.tbz
BTOP_SITE = https://github.com/aristocratos/btop/releases/download/v$(BTOP_VERSION)
BTOP_INSTALL_TARGET = YES
#BTOP_DEPENDENCIES = 

BTOP_LICENSE = Apache-2.0+
BTOP_LICENSE_FILES = LICENSE

define BTOP_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/share/btop/themes
    $(INSTALL) -D -m 0755 $(@D)/btop/bin/btop  $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 0755 $(@D)/btop/themes/*  $(TARGET_DIR)/usr/share/btop/themes
endef

$(eval $(generic-package))

