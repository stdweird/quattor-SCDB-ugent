unique template common/ofed/config;

# stock ELx rpms
variable OFED_IS_RDMA ?= is_defined(OFED_RELEASE_VERSION) && ! match(OFED_RELEASE_VERSION, "^mlnx");
variable OFED_IS_RDMA_NAME ?= { if (RPM_BASE_FLAVOUR_VERSIONID == 5) { 'ofed'; } else { 'rdma'; };};

include 'components/ofed/config';
"/software/components/ofed/openib/config" = {
    if(OFED_IS_RDMA) {
        if (RPM_BASE_FLAVOUR_VERSIONID == 5) {
            "/etc/ofed/openib.conf";
        } else {
            "/etc/rdma/rdma.conf";
        };
    } else {
        "/etc/infiniband/openib.conf";
    };
};

# no +RPM_BASE_FLAVOUR here. (changes are, OFED has fixed names)
include 'common/ofed/rpms/config';

include 'common/ofed/openib';

variable OPENSM_SERVERS ?= null;
include {
    if (is_defined(OPENSM_SERVERS)) {
        foreach(i;n;OPENSM_SERVERS) {
            if (match(FULL_HOSTNAME,"^"+n)) {
                return("common/ofed/opensm");
            };
        };
    };
};

include {
    if(match(OFED_RELEASE_VERSION,"QLogic")) {
        return("common/ofed/qlogic");
    };
};

variable IPOIB_CM ?= true;
prefix "/software/components/ofed/openib/";
"options/set_ipoib_cm" = IPOIB_CM;
"options/set_ipoib_channels" = false;
"options/node_desc" = HOSTNAME;
"modules/ucm" = true;

"/system/monitoring/hostgroups" = {
    append(SELF,"infiniband_nodes");
    SELF;
};

variable OFED_DRIVER ?= true;
variable OFED_BLACKLIST ?= true;
include { if(OFED_DRIVER) {'common/ofed/driver'}};
include { if(OFED_BLACKLIST) {'common/ofed/blacklist'}};

# Remove rdma during kickstart fase
include {
    if ( is_defined(AII_OSINSTALL_PACKAGES) && !OFED_IS_RDMA) {
        'common/ofed/ks_extra';
    };
};
