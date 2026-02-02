################################################################################
#
# perl-socket6
#
################################################################################
PERL_SOCKET6_VERSION = 0.29
PERL_SOCKET6_SOURCE = Socket6-$(PERL_SOCKET6_VERSION).tar.gz
PERL_SOCKET6_SITE = $(BR2_CPAN_MIRROR)/authors/id/U/UM/UMEMOTO
PERL_SOCKET6_DEPENDENCIES = host-perl-module-build
PERL_SOCKET6_LICENSE = Artistic or GPL-1.0+
PERL_SOCKET6_LICENSE_FILES = README
PERL_SOCKET6_DISTNAME = Socket6

$(eval $(perl-package))
$(eval $(host-perl-package))
