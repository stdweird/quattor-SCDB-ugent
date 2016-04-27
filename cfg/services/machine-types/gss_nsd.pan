template machine-types/gss_nsd;

variable GSS_NSD_CONFIG_SITE ?= null;

final variable OFED_DRIVER = false;
final variable OFED_BLACKLIST = false;

include 'machine-types/base';

include 'common/gss/service';

#
# Add site specific configuration, if any
include return(GSS_NSD_CONFIG_SITE);
include 'machine-types/post/base';
