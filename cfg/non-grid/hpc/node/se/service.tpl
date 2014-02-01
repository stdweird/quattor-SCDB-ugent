
unique template node/se/service;

# Include SE RPMs
include { 'node/se/rpms/config'+RPM_BASE_FLAVOUR };


include { 'node/se/monitoring' };

# Modify the loadable library path.
include { 'common/ldconf/config' };

variable USE_OFED ?= true;
include {if (USE_OFED) { 'common/ofed/service' } };

## DM multipath
variable USE_DMMULTIPATH ?= false;
include { if(USE_DMMULTIPATH) { 'common/dmmultipath/service' } };


## gpfs
variable USE_GPFS ?= false;
include { if(USE_GPFS) { 'common/gpfs/service' } };

## ctdb
variable USE_CTDB ?= false;
include { if(USE_CTDB) {'common/ctdb/service'} };
