############################################################
#
# object template machine-types/ce_torque
#
# Defines a CE, with an optional LRMS
#
############################################################

template machine-types/ce;


# Include base configuration of a gLite node
#
include { 'machine-types/base' };

 
#
# If CE uses Torque, do Torque configuration too
#
include { 'node/ce/service' };


variable CE_CONFIG_SITE ?= null;
# Add local customization to standard configuration, if any
include { return(CE_CONFIG_SITE) };


#
# updates
#
include { 'update/config' };

