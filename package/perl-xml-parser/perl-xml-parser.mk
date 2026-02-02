################################################################################
#
# perl-xml-parser
#
################################################################################

PERL_XML_PARSER_VERSION = 2.47
PERL_XML_PARSER_SOURCE = XML-Parser-$(PERL_XML_PARSER_VERSION).tar.gz
PERL_XML_PARSER_SITE = $(BR2_CPAN_MIRROR)/authors/id/T/TO/TODDR
PERL_XML_PARSER_DEPENDENCIES = zlib libxml2
PERL_XML_PARSER_LICENSE = Artistic or GPL-1.0+
PERL_XML_PARSER_LICENSE_FILES = LICENSE
PERL_XML_PARSER_CPE_ID_VENDOR = xml-parser
PERL_XML_PARSER_CPE_ID_PRODUCT = xml-parser
PERL_XML_PARSER_DISTNAME = XML-Parser

PERL_XML_PARSER_CONF_OPTS = \
	LIBS="-L $(STAGING_DIR)/usr/lib" \
	INC="-I $(STAGING_DIR)/usr/include/libxml2" \
	NO_THREADS

$(eval $(perl-package))
$(eval $(host-perl-package))
