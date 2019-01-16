################################################################################
#
# s6-linux-init
#
################################################################################

S6_LINUX_INIT_VERSION = 0.4.0.0
S6_LINUX_INIT_SITE = http://skarnet.org/software/s6-linux-init
S6_LINUX_INIT_LICENSE = ISC
S6_LINUX_INIT_LICENSE_FILES = COPYING
S6_LINUX_INIT_DEPENDENCIES = s6 s6-linux-utils s6-portable-utils host-s6-linux-init

S6_LINUX_INIT_CONF_OPTS = \
	--prefix=/usr \
	--with-sysdeps=$(STAGING_DIR)/usr/lib/skalibs/sysdeps \
	--with-include=$(STAGING_DIR)/usr/include \
	--with-dynlib=$(STAGING_DIR)/usr/lib \
	--with-lib=$(STAGING_DIR)/usr/lib/execline \
	--with-lib=$(STAGING_DIR)/usr/lib/s6 \
	--with-lib=$(STAGING_DIR)/usr/lib/skalibs \
	$(if $(BR2_STATIC_LIBS),,--disable-allstatic) \
	$(SHARED_STATIC_LIBS_OPTS)

define S6_LINUX_INIT_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./configure $(S6_LINUX_INIT_CONF_OPTS))
endef

define S6_LINUX_INIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define S6_LINUX_INIT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

HOST_S6_LINUX_INIT_DEPENDENCIES = host-s6

HOST_S6_LINUX_INIT_CONF_OPTS = \
	--prefix=$(HOST_DIR) \
	--with-sysdeps=$(HOST_DIR)/usr/lib/skalibs/sysdeps \
	--with-include=$(HOST_DIR)/usr/include \
	--with-dynlib=$(HOST_DIR)/usr/lib \
	--with-lib=$(HOST_DIR)/usr/lib/execline \
	--with-lib=$(HOST_DIR)/usr/lib/s6 \
	--with-lib=$(HOST_DIR)/usr/lib/skalibs \
	--disable-static \
	--enable-shared \
	--disable-allstatic

define HOST_S6_LINUX_INIT_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CONFIGURE_OPTS) ./configure $(HOST_S6_LINUX_INIT_CONF_OPTS))
endef

define HOST_S6_LINUX_INIT_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_S6_LINUX_INIT_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
