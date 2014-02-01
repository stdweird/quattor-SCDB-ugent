unique template common/ofed/openib;

variable USE_IPOIB ?= true;

variable OFED_IS_RDMA ?= false;
variable OPENIB_SERVICE_NAME ?= {
    if(OFED_IS_RDMA) {
        if (RPM_BASE_FLAVOUR_VERSIONID == 5) {
            "openibd";
        } else {
            "rdma";
        };
    } else {
        "openibd";
    };
};

## enable service
include { 'components/chkconfig/config' };
include { 'components/chkconfig/config' };
"/software/components/chkconfig/service" = {
    SELF[OPENIB_SERVICE_NAME] = nlist("on", "", "startstop", true);
    SELF;
};


## enable hardware
## check for each card the driver and load it
variable OFED_OPENIB_HARDWARE ?= {
    t=nlist();
    cards=value('/hardware/cards/ib');
    foreach(k;v;cards) {
        driverpath="/hardware/cards/ib/"+k+"/driver";
        if (is_defined(driverpath)) {
            driver=value(driverpath);
            t[driver]=true;
        } else {
            error("No driver for IB hardware "+k+" at path "+driverpath+"found.")
        };
    };
    t;
};
"/software/components/ofed/openib/hardware" = OFED_OPENIB_HARDWARE;


include { if (USE_IPOIB) { "common/ofed/ipoib" }};
