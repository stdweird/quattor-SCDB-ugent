
unique template node/se/service;

# Include SE RPMs
include 'node/se/rpms/config'+RPM_BASE_FLAVOUR;include 'node/se/monitoring';
# Modify the loadable library path.
include 'common/ldconf/config';
## DM multipath
variable USE_DMMULTIPATH ?= false;
include { if(USE_DMMULTIPATH) { 'common/dmmultipath/service' } };


## gpfs
variable USE_GPFS ?= false;
include { if(USE_GPFS) { 'common/gpfs/service' } };

## ctdb
variable USE_CTDB ?= false;
include { if(USE_CTDB) {'common/ctdb/service'} };

variable USE_GANESHA ?= false;
include {if(USE_GANESHA) {'common/ganesha/service'} };
