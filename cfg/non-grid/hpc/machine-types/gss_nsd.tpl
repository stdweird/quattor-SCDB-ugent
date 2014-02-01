template machine-types/gss_nsd;

variable GSS_NSD_CONFIG_SITE ?= null;


include { 'machine-types/base' };

final variable OFED_DRIVER = false;
final variable OFED_BLACKLIST = false;
variable USE_OFED ?= false;
include {if (USE_OFED) { 'common/ofed/service' } };

include 'common/gss/service';

#
# Add site specific configuration, if any
include { return(GSS_NSD_CONFIG_SITE) };


#
# updates
#
include { 'update/config' };
 
