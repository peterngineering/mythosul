################################################################################
#
# perl-xml-simple
#
################################################################################

PERL_XML_SIMPLE_VERSION = 2.25
PERL_XML_SIMPLE_SOURCE = XML-Simple-$(PERL_XML_SIMPLE_VERSION).tar.gz
PERL_XML_SIMPLE_SITE = $(BR2_CPAN_MIRROR)/authors/id/G/GR/GRANTM
PERL_XML_SIMPLE_DEPENDENCIES = zlib libxml2
PERL_XML_SIMPLE_LICENSE = Artistic or GPL-1.0+
PERL_XML_SIMPLE_LICENSE_FILES = LICENSE
PERL_XML_SIMPLE_CPE_ID_VENDOR = xml-simple
PERL_XML_SIMPLE_CPE_ID_PRODUCT = xml-simple
PERL_XML_SIMPLE_DISTNAME = XML-Simple

PERL_XML_SIMPLE_CONF_OPTS = \
	LIBS="-L $(STAGING_DIR)/usr/lib" \
	INC="-I $(STAGING_DIR)/usr/include/libxml2" \
	NO_THREADS

$(eval $(perl-package))
$(eval $(host-perl-package))
