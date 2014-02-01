############################################################
#
# object template machine-types/ce_torque
#
# Defines a SE
#
############################################################

template machine-types/se;


# Include base configuration of a gLite node
#
variable NAGIOS_CHECK_CPU_WARN ?= list(101,40,40);

include { 'machine-types/base' };

 
#
# If CE uses Torque, do Torque configuration too
#
include { 'node/se/service' };


variable SE_CONFIG_SITE ?= null;
# Add local customization to standard configuration, if any
include { return(SE_CONFIG_SITE) };


#
# updates
#
include { 'update/config' };

