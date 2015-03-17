################################################################################
#
# libaio
#
################################################################################

LIBAIO_VERSION = 0.3.110
#LIBAIO_SOURCE = libaio_$(LIBAIO_VERSION).orig.tar.gz
LIBAIO_SOURCE = libaio-0.3.110.tar.gz
#LIBAIO_SITE = http://snapshot.debian.org/archive/debian/20110227T085214Z/pool/main/liba/libaio/
LIBAIO_SITE = http://pkgs.fedoraproject.org/repo/pkgs/libaio/libaio-0.3.110.tar.gz/2a35602e43778383e2f4907a4ca39ab8/
LIBAIO_SITE = http://pkgs.fedoraproject.org/repo/pkgs/libaio/libaio-0.3.110.tar.gz/2a35602e43778383e2f4907a4ca39ab8/
LIBAIO_INSTALL_STAGING = YES
LIBAIO_LICENSE = LGPLv2.1+
LIBAIO_LICENSE_FILES = COPYING

define LIBAIO_BUILD_CMDS
  $(TARGET_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBAIO_INSTALL_STAGING_CMDS
  $(TARGET_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define LIBAIO_INSTALL_TARGET_CMDS
  $(TARGET_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
