###############################################################################
#
# mythtv
#
###############################################################################

# v35-fixes from upstream
# commit/931474b3a0c98aa80ceb7903359af2024726156e
#
###############################################################################
MYTHTV_VERSION = 931474b3a0c98aa80ceb7903359af2024726156e
MYTHTV_SOURCE = mythtv-$(MYTHTV_VERSION).tar.gz
MYTHTV_SITE = $(call github,mythtv,mythtv,$(MYTHTV_VERSION))

MYTHTV_SUBDIR = mythtv
MYTHTV_INSTALL_TARGET = YES
MYTHTV_INSTALL_TARGET_OPTS = INSTALL_ROOT=$(TARGET_DIR) install

MYTHTV_LICENSE = LGPL-2.1+, libjpeg license
MYTHTV_LICENSE_FILES = LICENSE.md COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_MYTHTV_GPL),y)
MYTHTV_LICENSE += and GPL-2.0+
MYTHTV_LICENSE_FILES += COPYING.GPLv2
endif


#--enable-lto does NOT work when tried here, yet will work on a native build
MYTHTV_CONF_OPTS = \
	--prefix=/usr \
	--enable-small \
	--disable-debug \
	--compile-type=release

MYTHTV_DEPENDENCIES += host-pkgconf \
		       freetype libbluray libsamplerate libsoundtouch libxml2 \
		       libzip lzo qt5base taglib

ifeq ($(BR2_PACKAGE_MYTHTV_GPL),y)
MYTHTV_CONF_OPTS += --enable-gpl
else
MYTHTV_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_MYTHTV_NONFREE),y)
MYTHTV_CONF_OPTS += --enable-nonfree
else
MYTHTV_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_MYTHTV_FFMPEG),y)
MYTHTV_CONF_OPTS += --enable-ffmpeg
else
MYTHTV_CONF_OPTS += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_MYTHTV_FFMPEG_FFPLAY),y)
MYTHTV_DEPENDENCIES += sdl2
MYTHTV_CONF_OPTS += --enable-ffplay
MYTHTV_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config
else
MYTHTV_CONF_OPTS += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_MYTHTV_FFMPEG_FFPROBE),y)
MYTHTV_CONF_OPTS += --enable-ffprobe
else
MYTHTV_CONF_OPTS += --disable-ffprobe
endif

#input options
ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_JOYSTICK_MENU),y)
MYTHTV_CONF_OPTS += --enable-joystick-menu
else
MYTHTV_CONF_OPTS += --disable-joystick-menu
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_LIRC),y)
MYTHTV_CONF_OPTS += --enable-lirc
else
MYTHTV_CONF_OPTS += --disable-lirc
endif

ifeq ($(BR2_PACKAGE_LIBCEC),y)
MYTHTV_CONF_OPTS += --enable-libcec
else
MYTHTV_CONF_OPTS += --disable-libcec
endif

ifeq ($(BR2_PACKAGE_LIBV4L),y)
MYTHTV_CONF_OPTS += --enable-v4l2
MYTHTV_DEPENDENCIES += libv4l
else
MYTHTV_CONF_OPTS += --disable-v4l2
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_SATIP),y)
MYTHTV_CONF_OPTS += --enable-satip
else
MYTHTV_CONF_OPTS += --disable-satip
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_FIREWIRE),y)
MYTHTV_CONF_OPTS += --enable-firewire
else
MYTHTV_CONF_OPTS += --disable-firewire
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_DVB),y)
MYTHTV_CONF_OPTS += --enable-dvb
else
MYTHTV_CONF_OPTS += --disable-dvb
endif

ifeq ($(BR2_PACKAGE_LIBHDHOMERUN),y)
MYTHTV_CONF_OPTS += --enable-hdhomerun
MYTHTV_DEPENDENCIES += libhdhomerun
else
MYTHTV_CONF_OPTS += --disable-hdhomerun
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_VBOX),y)
MYTHTV_CONF_OPTS += --enable-vbox
else
MYTHTV_CONF_OPTS += --disable-vbox
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_CETON),y)
MYTHTV_CONF_OPTS += --enable-ceton
else
MYTHTV_CONF_OPTS += --disable-ceton
endif

ifeq ($(BR2_PACKAGE_MYTHTV_INPUT_ASI),y)
MYTHTV_CONF_OPTS += --enable-asi
else
MYTHTV_CONF_OPTS += --disable-asi
endif

		       #perl-module-build 
		      # perl-clone 
ifeq ($(BR2_PACKAGE_PERL),y)
MYTHTV_CONF_OPTS += --enable-bindings_perl
MYTHTV_DEPENDENCIES += perl \
		       perl-date-manip \
		       host-perl-dbi \
		       perl-dbi \
		       host-perl-dbd-mysql \
		       perl-dbd-mysql \
		       perl-http-date \
		       perl-http-message \
		       perl-io-socket-inet6 \
		       perl-libwww-perl \
		       host-perl-module-build \
		       perl-net-upnp \
		       host-perl-socket6 \
		       perl-try-tiny \
		       perl-uri \
		       perl-xml-simple 
else
MYTHTV_CONF_OPTS += --disable-bindings_perl
endif

ifeq ($(BR2_PACKAGE_MYTHTV_BINDINGS_PHP),y)
MYTHTV_CONF_OPTS += --enable-bindings_php
else
MYTHTV_CONF_OPTS += --disable-bindings_php
endif

ifeq ($(BR2_PACKAGE_MYTHTV_BINDINGS_PYTHON),y)
MYTHTV_CONF_OPTS += --enable-bindings_python
#MYTHTV_DEPENDENCIES += python
else
MYTHTV_CONF_OPTS += --disable-bindings_python
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
MYTHTV_CONF_OPTS += --enable-audio-pulse
MYTHTV_DEPENDENCIES += pulseaudio
else
MYTHTV_CONF_OPTS += --disable-audio-pulse
endif

ifeq ($(BR2_PACKAGE_MYTHTV_SOUND_OUTPUT_OSS),y)
MYTHTV_CONF_OPTS += --enable-audio-oss
#MYTHTV_DEPENDENCIES += alsa-lib
#else
#MYTHTV_CONF_OPTS += --disable-audio-oss
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
MYTHTV_CONF_OPTS += --enable-alsa
MYTHTV_DEPENDENCIES += alsa-lib
else
MYTHTV_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_JACK1),y)
MYTHTV_CONF_OPTS += --enable-audio-jack
MYTHTV_DEPENDENCIES += jack1
else
MYTHTV_CONF_OPTS += --disable-audio-jack
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
MYTHTV_CONF_OPTS += --enable-gnutls 
#--disable-openssl
MYTHTV_DEPENDENCIES += gnutls
else
MYTHTV_CONF_OPTS += --disable-gnutls
endif

#ifeq ($(BR2_PACKAGE_OPENSSL),y)
## openssl isn't license compatible with GPL
#ifeq ($(BR2_PACKAGE_MYTHTV_GPL)x$(BR2_PACKAGE_MYTHTV_NONFREE),yx)
#MYTHTV_CONF_OPTS += --disable-openssl
#else
#MYTHTV_CONF_OPTS += --enable-openssl
#MYTHTV_DEPENDENCIES += openssl
#endif
#else
#MYTHTV_CONF_OPTS += --disable-openssl
#endif
#endif

#VIDEO OPTIONS
ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_X11),y)
MYTHTV_CONF_OPTS += --enable-x11
#MYTHTV_DEPENDENCIES += libx11
else
MYTHTV_CONF_OPTS += --disable-x11
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_X11)$(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_LIBVDPAU),yy)
MYTHTV_CONF_OPTS += --enable-vdpau
MYTHTV_DEPENDENCIES += libvdpau
else
MYTHTV_CONF_OPTS += --disable-vdpau
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_X11)$(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_NVDEC),yy)
MYTHTV_CONF_OPTS += --enable-nvdec
MYTHTV_DEPENDENCIES += libx11
else
MYTHTV_CONF_OPTS += --disable-nvdec
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_VAAPI),y)
MYTHTV_CONF_OPTS += --enable-vaapi
MYTHTV_DEPENDENCIES += libva
else
MYTHTV_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_DRM),y)
MYTHTV_CONF_OPTS += --enable-drm
MYTHTV_DEPENDENCIES += libdrm
else
MYTHTV_CONF_OPTS += --disable-drm
endif

#opengl is mandatory
ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_OPENGL),y)
MYTHTV_CONF_OPTS += --enable-opengl
MYTHTV_DEPENDENCIES += 
else
MYTHTV_CONF_OPTS += --disable-opengl
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_DRM)$(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_EGL),yy)
MYTHTV_CONF_OPTS += --enable-egl
#MYTHTV_DEPENDENCIES += 
else
MYTHTV_CONF_OPTS += --disable-egl
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_VULKAN),y)
MYTHTV_CONF_OPTS += --enable-vulkan
#MYTHTV_DEPENDENCIES += 
endif

ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_MHEG),y)
MYTHTV_CONF_OPTS += --enable-mheg
#MYTHTV_DEPENDENCIES += 
else
MYTHTV_CONF_OPTS += --disable-mheg
endif

ifeq ($(BR2_PACKAGE_LIBASS),y)
MYTHTV_CONF_OPTS += --enable-libass
MYTHTV_DEPENDENCIES += libass
else
MYTHTV_CONF_OPTS += --disable-libass
endif

#Misc options

ifeq ($(BR2_PACKAGE_LIBXML2),y)
MYTHTV_CONF_OPTS += --enable-libxml2
MYTHTV_DEPENDENCIES += libxml2
else
MYTHTV_CONF_OPTS += --disable-libxml2
endif

ifeq ($(BR2_PACKAGE_AVAHI_LIBDNSSD_COMPATIBILITY),y)
MYTHTV_CONF_OPTS += --enable-libdns-sd
#MYTHTV_DEPENDENCIES += avahi
else
MYTHTV_CONF_OPTS += --disable-libdns-sd
endif

#ifeq ($(BR2_PACKAGE_MYTHTV_VIDEO_OUTPUT_DRM)$(BR2_PACKAGE_MYTHTV_MISC_DRM_QT_INTEGRATION),yy)
#MYTHTV_CONF_OPTS += --enable-qtprivateheaders
#MYTHTV_DEPENDENCIES += libdrm
#endif

#Misc option
#ifeq ($(BR2_PACKAGE_MYTHTV_MISC_DRM_QT_INTEGRATION)$(BR2_PACKAGE_MYTHTV_MISC_WAYLANDEXTRAS),yy)
#MYTHTV_CONF_OPTS += --enable-waylandextras
#MYTHTV_DEPENDENCIES += 
#else
#MYTHTV_CONF_OPTS += --disable-waylandextras
#endif

#apply this type to libav* it shows serveral circular deps when building
# To avoid a circular dependency only use opencv if opencv itself does
# not depend on mythtv.
#ifeq ($(BR2_PACKAGE_OPENCV_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV_WITH_MYTHTV),yx)
#MYTHTV_CONF_OPTS += --enable-libopencv
#MYTHTV_DEPENDENCIES += opencv
#else ifeq ($(BR2_PACKAGE_OPENCV3_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV3_WITH_MYTHTV),yx)
#MYTHTV_CONF_OPTS += --enable-libopencv
#MYTHTV_DEPENDENCIES += opencv3
#else
#MYTHTV_CONF_OPTS += --disable-libopencv
#endif

#ext codec options
ifeq ($(BR2_PACKAGE_LAME),y)
MYTHTV_CONF_OPTS += --enable-libmp3lame
MYTHTV_DEPENDENCIES += lame
else
MYTHTV_CONF_OPTS += --disable-libmp3lame
endif

ifeq ($(BR2_PACKAGE_MYTHTV_EXTERNAL_CODEC_OPTIONS_LIBXVID),y)
MYTHTV_CONF_OPTS += --enable-libxvid
#MYTHTV_DEPENDENCIES += libxvid
else
MYTHTV_CONF_OPTS += --disable-libxvid
endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_MYTHTV_GPL),yy)
MYTHTV_CONF_OPTS += --enable-libx264
MYTHTV_DEPENDENCIES += x264
else
MYTHTV_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_PACKAGE_X265)$(BR2_PACKAGE_MYTHTV_GPL),yy)
MYTHTV_CONF_OPTS += --enable-libx265
MYTHTV_DEPENDENCIES += x265
else
MYTHTV_CONF_OPTS += --disable-libx265
endif

ifeq ($(BR2_PACKAGE_LIBAOM),y)
MYTHTV_CONF_OPTS += --enable-libaom
#MYTHTV_DEPENDENCIES += libaom
else
MYTHTV_CONF_OPTS += --disable-libaom
endif

ifeq ($(BR2_PACKAGE_LIBDAV1D),y)
MYTHTV_CONF_OPTS += --enable-libdav1d
MYTHTV_DEPENDENCIES += dav1d
else
MYTHTV_CONF_OPTS += --disable-libdav1d
endif

#cpu
ifeq ($(BR2_x86_64),y)
MYTHTV_CONF_OPTS += --cpu=x86_64
endif

ifeq ($(BR2_aarch64),y)
MYTHTV_CONF_OPTS += --cpu=aarch64
endif

ifeq ($(BR2_cortex_a73),y)
MYTHTV_CONF_OPTS += --cpu=cortex-a73
endif

ifeq ($(BR2_cortex_a72),y)
MYTHTV_CONF_OPTS += --cpu=cortex-a72
endif

ifeq ($(BR2_cortex_a53),y)
MYTHTV_CONF_OPTS += --cpu=cortex-a53
endif

ifeq ($(BR2_cortex_a17),y)
MYTHTV_CONF_OPTS += --cpu=cortex-a17
endif

ifeq ($(BR2_cortex_a7),y)
MYTHTV_CONF_OPTS += --cpu=cortex-a7
endif

#ifeq ($(BR2_ARM_CPU_ARMV7A),y)
#MYTHTV_CONF_OPTS += --enable-armv7  
#else
#MYTHTV_CONF_OPTS += --disable-armv7
#endif

#ifeq ($(BR2_arm1176jzf_s),y)
#MYTHTV_CONF_OPTS += --cpu=armv6 
#endif

ifeq ($(BR2_ARM_CPU_HAS_VFPV3),y)
MYTHTV_CONF_OPTS += --enable-vfpv3
else
MYTHTV_CONF_OPTS += --disable-vfpv3
endif

ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
MYTHTV_CONF_OPTS += --enable-vfp
else
MYTHTV_CONF_OPTS += --disable-vfp
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MYTHTV_CONF_OPTS += --enable-neon
else ifeq ($(BR2_aarch64),y)
MYTHTV_CONF_OPTS += --enable-neon
else
MYTHTV_CONF_OPTS += --disable-neon
endif

#ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
#MYTHTV_CFLAGS += -marm
#endif


MYTHTV_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_MYTHTV_EXTRACONF))

#$(SHARED_STATIC_LIBS_OPTS) 
# Override MYTHTV_CONFIGURE_CMDS: mythtv does not support --target and others
define MYTHTV_CONFIGURE_CMDS
	(cd $(MYTHTV_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(MYTHTV_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(MYTHTV_CONF_OPTS) \
	)
endef


ifeq ($(BR2_PACKAGE_MYTHTV),y)
define MYTHTV_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/mythtv/INIT_D/S99mythfrontend \
		$(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 755 package/mythtv/INIT_D/S98mythbackend \
		$(TARGET_DIR)/etc/init.d
endef

#define MYTHTV_INSTALL_INIT_SYSTEMD
#	$(INSTALL) -D -m 755 package/mythtv/SYSTEMD/mythfrontend.service \
#	       	$(TARGET_DIR)/usr/lib/systemd/system
#	$(INSTALL) -D -m 755 package/mythtv/SYSTEMD/mythbackend.service \
#	       	$(TARGET_DIR)/usr/lib/systemd/system
#endef

define MYTHTV_INSTALL_MISC_BIN
	mkdir -p $(TARGET_DIR)/root/bin
	$(INSTALL) -D -m 755 package/mythtv/BIN/*.sh \
		$(TARGET_DIR)/root/bin
endef

define MYTHTV_INSTALL_CONTRIB
	$(INSTALL) -D -m 755 package/mythtv/CONTRIB/user_jobs/mythlink.pl \
		$(TARGET_DIR)/usr/share/mythtv
endef

define MYTHTV_INSTALL_CONFIGSVR
	mkdir -p $(TARGET_DIR)/etc/mythtv
	$(INSTALL) -D -m 755 package/mythtv/FESVR_CONFIGS/SVR/config.xml \
		$(TARGET_DIR)/etc/mythtv
	chown -R 1000:1000 $(TARGET_DIR)/etc/mythtv
endef

define MYTHTV_INSTALL_CONFIGFE
	mkdir -p $(TARGET_DIR)/root/.mythtv
	$(INSTALL) -D -m 755 package/mythtv/FESVR_CONFIGS/FE/config.xml \
		$(TARGET_DIR)/root/.mythtv
endef

define MYTHTV_INSTALL_CPUFREQ_TOGGLES
	mkdir -p $(TARGET_DIR)/home/mythtv/bin
	$(INSTALL) -D -m 755 package/mythtv/CPUFREQ/*.sh \
		$(TARGET_DIR)/home/mythtv/bin
endef

define MYTHTV_INSTALL_JSON
	mkdir -p $(TARGET_DIR)/home/mythtv/JSON
	$(INSTALL) -D -m 644 package/mythtv/JSON/mythfrontend*.json \
		$(TARGET_DIR)/home/mythtv/JSON
endef

define MYTHTV_INSTALL_UDEV_RULES
	$(INSTALL) -D -m 644 package/mythtv/UDEV/99-mythbackend-udev.rules \
		$(TARGET_DIR)/etc/udev/rules.d
	$(INSTALL) -D -m 644 package/mythtv/UDEV/10-vc-udev.rules \
		$(TARGET_DIR)/etc/udev/rules.d
endef
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_MISC_BIN
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_CONTRIB
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_CONFIGFE
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_CONFIGSVR
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_CPUFREQ_TOGGLES
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_JSON
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_UDEV_RULES
endif


#temp hack 
#install perl bindings to right target/clean up(HARDCODED HOMDIR) wrong target
#todo try using other vars ehre to identify /home/br like eg. $(HOME)
ifeq ($(BR2_PACKAGE_MYTHTV_BINDINGS_PERL),y)
define MYTHTV_INSTALL_PERL_MYTHTV_BINDINGS
	mkdir -p $(TARGET_DIR)/usr/lib/perl5/site_perl/5.40.2/IO/Socket/INET
	$(INSTALL) -D -m 644 $(MYTHTV_SRCDIR)/bindings/perl/IO/Socket/INET/MythTV.pm \
		$(TARGET_DIR)/usr/lib/perl5/site_perl/5.40.2/IO/Socket/INET 
	$(INSTALL) -D -m 644 $(MYTHTV_SRCDIR)/bindings/perl/MythTV.pm \
		$(TARGET_DIR)/usr/lib/perl5/site_perl/5.40.2 
	mkdir -p $(TARGET_DIR)/usr/lib/perl5/site_perl/5.40.2/MythTV
	$(INSTALL) -D -m 644 $(MYTHTV_SRCDIR)/bindings/perl/MythTV/*.pm \
		$(TARGET_DIR)/usr/lib/perl5/site_perl/5.40.2/MythTV
	rm -rf $(TARGET_DIR)/home/br
endef
MYTHTV_POST_INSTALL_TARGET_HOOKS += MYTHTV_INSTALL_PERL_MYTHTV_BINDINGS
endif


$(eval $(autotools-package))
