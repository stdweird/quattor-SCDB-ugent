unique template common/ganesha/service;

variable GANESHA_FSAL ?= undef;
variable GANESHA_SERVICE ?= format('nfs-ganesha-%s',GANESHA_FSAL);

variable CTDB_MANAGES_GANESHA ?= false;

include {'common/ganesha/config'};
include {'common/ganesha/packages'};

## enable/disable ganesha
"/software/components/chkconfig/service" = {
    if (CTDB_MANAGES_GANESHA) {
        SELF[GANESHA_SERVICE] = nlist(
            "off", "",
            "startstop", false
            );
    } else {
        SELF[GANESHA_SERVICE] = nlist(
            "on", "",
            "startstop", true
            );
    };
    SELF;
};


## disable nfs and friends
prefix "/software/components/chkconfig/service";
"nfs/off" = "";
"nfs/startstop" = false;
"nfslock/off" = "";
"nfslock/startstop" = false;
"rpcgssd/off" = "";
"rpcgssd/startstop" = false;
"rpcidmapd/off" = "";
"rpcidmapd/startstop" = false;
"rpcsvcgssd/off" = "";
"rpcsvcgssd/startstop" = false;

# start rpcbind, so statd can be started
"rpcbind/on" = "";
"rpcbind/startstop" = true;
