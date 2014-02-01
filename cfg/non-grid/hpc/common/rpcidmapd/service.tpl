unique template common/rpcidmapd/service;

# some tools use nfs-utils-lib instead of the daemon
variable RPCIDMAPD_RUNNING ?= true;

include { "common/rpcidmapd/config" };

## add service multipathd
"/software/components/chkconfig/service/rpcidmapd" = {
    if(RPCIDMAPD_RUNNING) {
        state='on';
    } else {
        state='off';
    };
    nlist(state, "","startstop", true);
};


