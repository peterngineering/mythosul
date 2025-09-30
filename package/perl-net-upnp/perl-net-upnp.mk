################################################################################
#
# perl-net-upnp
#
################################################################################

PERL_NET_UPNP_VERSION = 1.4.6
PERL_NET_UPNP_SOURCE = Net-UPnP-$(PERL_NET_UPNP_VERSION).tar.gz
PERL_NET_UPNP_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SK/SKONNO
PERL_NET_UPNP_DEPENDENCIES = host-perl-module-build
PERL_NET_UPNP_LICENSE = Artistic or GPL-1.0+
PERL_NET_UPNP_LICENSE_FILES = LICENSE
PERL_NET_UPNP_DISTNAME = Net-UPnP

$(eval $(perl-package))
$(eval $(host-perl-package))
