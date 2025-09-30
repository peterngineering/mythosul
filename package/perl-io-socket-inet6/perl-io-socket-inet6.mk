################################################################################
#
# perl-io-socket-inet6
#
################################################################################
PERL_IO_SOCKET_INET6_VERSION = 2.73
PERL_IO_SOCKET_INET6_SOURCE = IO-Socket-INET6-$(PERL_IO_SOCKET_INET6_VERSION).tar.gz
PERL_IO_SOCKET_INET6_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SH/SHLOMIF
PERL_IO_SOCKET_INET6_DEPENDENCIES = host-perl-module-build
PERL_IO_SOCKET_INET6_LICENSE = Artistic or GPL-1.0+
PERL_IO_SOCKET_INET6_LICENSE_FILES = README
PERL_IO_SOCKET_INET6_DISTNAME = IO-Socket-INET6

$(eval $(perl-package))
$(eval $(host-perl-package))
