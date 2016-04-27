unique template common/ofed/openib;

variable USE_IPOIB ?= true;

variable OFED_IS_RDMA ?= is_defined(OFED_RELEASE_VERSION) && ! match(OFED_RELEASE_VERSION, "^mlnx");
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

# enable service

# according to mellanox support, ibacm is not a mandatory service to
# maintain proper IB or RoCE trasport between melanox-adapters
# (and with ibacm running, rsocket fails or is very unstable)
variable OFED_IBACM ?= false;
include 'components/chkconfig/config';
"/software/components/chkconfig/service" = {
    SELF[OPENIB_SERVICE_NAME] = dict("on", "", "startstop", true);

    ibacm = 'off';
    if(OFED_IBACM) { ibacm = 'on'; };
    SELF['ibacm'] = dict(ibacm, "", "startstop", true);

    SELF;
};


## enable hardware
## check for each card the driver and load it
variable OFED_OPENIB_HARDWARE ?= {
    t=dict();
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
