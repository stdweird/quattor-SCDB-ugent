template machine-types/ce;

variable DISK_SWAP_SIZE_MULTIPLIER = 1;

# Include base configuration of a gLite node
include 'machine-types/base';
 
# If CE uses Torque, do Torque configuration too
include 'node/ce/service';

# Add local customization to standard configuration, if any
variable CE_CONFIG_SITE ?= null;
include CE_CONFIG_SITE;
include 'machine-types/post/base';
