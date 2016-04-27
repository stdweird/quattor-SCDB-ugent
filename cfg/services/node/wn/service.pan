# Template defining all the MW components required to run a WN

unique template node/wn/service;


variable USE_VSMP ?= false;
## first include VSMP preservice
## will modify the hardware + set vsmp path
include { if(USE_VSMP) { 'common/vsmp/preservice' } };

#
# gLite WN configuration
#
include 'node/wn/rpms/config';
variable LRMS_CLIENT_INCLUDE = {
  if ( exists(CE_BATCH_NAME) && is_defined(CE_BATCH_NAME) ) {
    return("common/"+CE_BATCH_NAME+"/client/service");
  } else {
    return(null);
  };
};
include LRMS_CLIENT_INCLUDE;
# Modify the loadable library path.
include 'common/ldconf/config';include 'node/wn/monitoring';
# Configure NFS
# Configure NFS
variable USE_NFS ?= true;
include { if(USE_NFS) {'common/nfs/client/config'} };


## cpusets
variable USE_CPUSET ?= false;
variable USE_CGROUPS_AS_CPUSET ?= match(TORQUE_RPM_VERSION,'^[6-9]\.');
include {
    if(USE_CPUSET) {
        if (USE_CGROUPS_AS_CPUSET) {
            'common/cgroups/service';
        } else {
            'common/cpuset/service';
        };
    };
};

## limic
variable USE_LIMIC ?= false;
include { if(USE_LIMIC) { 'common/limic/service' } };

## knem
variable USE_KNEM ?= false;
include { if(USE_KNEM) { 'common/knem/service' } };

## perfctr
variable USE_PERFCTR ?= false;
include { if(USE_PERFCTR) { 'common/perfctr/service' } };

include 'common/sysctl/service';

## on top of OS_UNWANTED_DEFAULT_DAEMONS
variable WN_UNWANTED_DEFAULT_DAEMONS ?= list (
    "cpuspeed", "ip6tables", "iptables",
    "arptables_jf", "auditd", "kudzu",
    "mcstrans", "haldaemon", "hidd",
    "xinetd", "uuidd", "sendmail", "xfs","irqbalance"
);
"/software/components/chkconfig/service/" = {
    stoplist = WN_UNWANTED_DEFAULT_DAEMONS;
    foreach(k;v;stoplist) {
        SELF[v]=dict("off","","startstop",true);
    };
    SELF;
};

variable USE_DET ?= {
    if(is_defined(USE_OFED) && USE_OFED) {
        return(false);
    } else {
        return(true);
    };
};
include {if(USE_DET) { 'common/det/service' } };

variable USE_CPUSPEED ?= true;
include { if(USE_CPUSPEED) { 'common/cpuspeed/service' } };

## gpfs
variable USE_GPFS ?= false;
include { if(USE_GPFS) { 'common/gpfs/service' } };

## hoard
variable USE_HOARD ?= true;
include { if(USE_HOARD) { 'common/hoard/service' } };

## now include VSMP service
include { if(USE_VSMP) { 'common/vsmp/service' } };
