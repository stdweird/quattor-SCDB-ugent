# Template defining all the MW components required for a LCG CE
# Include Torque/MAUI server if used as LRMS

unique template node/ce/service;

# Configure LRMS if one specified
variable LRMS_SERVER_INCLUDE = {
  if ( exists(CE_BATCH_NAME) && is_defined(CE_BATCH_NAME) ) {
    return("common/"+CE_BATCH_NAME+"/server/service");
  } else {
    return(null);
  };
};
include LRMS_SERVER_INCLUDE;include 'node/ce/monitoring';
# Mount NFS shared areas if any
include 'common/nfs/client/config';
# Modify the loadable library path. 
include 'common/ldconf/config';
## nscd
variable USE_NSCD ?= false;
include { if(USE_NSCD) { 'common/nscd/service' } };

variable USE_POSTFIX ?= true;
include { if(USE_POSTFIX) { 'common/postfix/service' } };

variable USE_RSYNCD ?= false;
include { if(USE_RSYNCD) { 'common/rsync/service' } };

"/software/packages/{python-simplejson}" = dict();

variable USE_PBSMON2PHP_CLIENT ?= false;
include { if(USE_PBSMON2PHP_CLIENT) { 'common/pbsmon2php/client-service' } };

variable USE_CPUSPEED ?= true;
include { if(USE_CPUSPEED) {'common/cpuspeed/service'} };

## gpfs
variable USE_GPFS ?= false;
include { if(USE_GPFS) { 'common/gpfs/service' } };
