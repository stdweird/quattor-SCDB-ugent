############################################################
#
# object template machine-types/ui
#
# Common worker node definition (architecture independant).
#
############################################################

template machine-types/ui;

variable UI_CONFIG_SITE ?= null;

#
# Must be done before calling machine-types/base
# Home directories for pool accounts are created only if a shared filesystem
# is not used or if the NFS server for the filesystem is the current node.
#

#
# Include base configuration of a gLite node
#
include { 'machine-types/base' };

# Include WN components
include { 'node/ui/service' };

#
# Add site specific configuration, if any
include { return(UI_CONFIG_SITE) };


#
# updates
#
include { 'update/config' };
 
