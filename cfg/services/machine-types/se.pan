template machine-types/se;

variable NAGIOS_CHECK_CPU_WARN ?= list(101, 40, 40);

include 'machine-types/base';


include 'node/se/service';


variable SE_CONFIG_SITE ?= null;
# Add local customization to standard configuration, if any
include SE_CONFIG_SITE;
include 'machine-types/post/base';
