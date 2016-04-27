unique template common/ganesha/service;

variable GANESHA_VERSION_2 ?= true;

variable GANESHA_SERVICE ?= {
    if (GANESHA_VERSION_2) {
        'nfs-ganesha';
    } else {
        format('nfs-ganesha-%s',GANESHA_FSAL);
    };  
};
include 'common/ganesha/config';
include 'common/ganesha/packages';
## enable/disable ganesha
"/software/components/chkconfig/service" = {
    if (GANESHA_MANAGES_GANESHA) {
        SELF[GANESHA_SERVICE] = dict(
            "on", "",
            "startstop", true
            );
    } else {
        SELF[GANESHA_SERVICE] = dict(
            "off", "",
            "startstop", false
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
