unique template common/ganesha/config;


final variable METACONFIG_GANESHA_VERSION = {if(GANESHA_VERSION_2) {'v2'} else {'v1'}};

include 'metaconfig/ganesha/config';

include { format('common/ganesha/config_%s', METACONFIG_GANESHA_VERSION)};

# FSAL settings
include { format('common/ganesha/fsal/%s', GANESHA_FSAL) };

variable GANESHA_SITE ?= 'site/ganesha';
include GANESHA_SITE;
