unique template common/rpcidmapd/service;

# some tools use nfs-utils-lib instead of the daemon
variable RPCIDMAPD_RUNNING ?= true;
include "common/rpcidmapd/config";
## add service rpcidmapd
"/software/components/chkconfig/service" = {
    if(RPCIDMAPD_RUNNING) {
        state='on';
    } else {
        state='off';
    };
    SELF[RPCIDMAPD_SERVICE] = dict(state, "","startstop", true);
    SELF;
};
