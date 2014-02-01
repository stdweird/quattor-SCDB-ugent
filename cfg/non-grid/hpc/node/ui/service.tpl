# Template defining all the MW components required to run a UI

unique template node/ui/service;

#
include { 'node/ui/rpms/config' };

variable LRMS_CLIENT_TYPE ?= 'client';
variable LRMS_CLIENT_INCLUDE =  if ( exists(CE_BATCH_NAME) && is_defined(CE_BATCH_NAME) ) {
    format("common/%s/%s/service", CE_BATCH_NAME, LRMS_CLIENT_TYPE);
};
include { LRMS_CLIENT_INCLUDE };

# Modify the loadable library path.
include { 'common/ldconf/config' };

include { 'node/ui/monitoring' };

# Configure NFS
variable USE_NFS ?= true;
include { if(USE_NFS) {'common/nfs/client/config'} };

## perfctr
variable USE_PERFCTR ?= false;
include { if(USE_PERFCTR) { 'common/perfctr/service' } };


include {'common/sysctl/service'};

## on top of OS_UNWANTED_DEFAULT_DAEMONS
variable WN_UNWANTED_DEFAULT_DAEMONS ?= list ("cpuspeed", "ip6tables", "iptables", "arptables_jf", "auditd", "kudzu", "mcstrans", "haldaemon", "hidd", "xinetd", "uuidd", "sendmail", "xfs");
"/software/components/chkconfig/service/" = {
    stoplist = WN_UNWANTED_DEFAULT_DAEMONS;
    foreach(k;v;stoplist) {
        SELF[v] = nlist("off","","startstop",true);
    };
    SELF;
};

variable USE_CPUSPEED ?= true;
include { if(USE_CPUSPEED) { 'common/cpuspeed/service' } };

## gpfs
variable USE_GPFS ?= false;
include { if(USE_GPFS) { 'common/gpfs/service' } };

variable USE_CPUSPEED ?= true;
include { if(USE_CPUSPEED) { 'common/cpuspeed/service' } };

variable USE_OFED ?= false;
include {if (USE_OFED) { 'common/ofed/service' } };


## shorewall
variable UI_SHOREWALL = "site/uinetwork";
variable USE_SHOREWALL ?= true;
include {if(USE_SHOREWALL) {UI_SHOREWALL}};
include {if(USE_SHOREWALL) {'common/shorewall/service'}};
