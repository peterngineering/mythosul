################################################################################
#
# perl-xml-sax-expat
#
################################################################################

PERL_XML_SAX_EXPAT_VERSION = 0.51
PERL_XML_SAX_EXPAT_SOURCE = XML-SAX-Expat-$(PERL_XML_SAX_EXPAT_VERSION).tar.gz
PERL_XML_SAX_EXPAT_SITE = $(BR2_CPAN_MIRROR)/authors/id/B/BJ/BJOERN
PERL_XML_SAX_EXPAT_LICENSE = Artistic or GPL-1.0+
PERL_XML_SAX_EXPAT_LICENSE_FILES = README
PERL_XML_SAX_EXPAT_DISTNAME = XML-SAX-Expat

$(eval $(perl-package))
$(eval $(host-perl-package))
