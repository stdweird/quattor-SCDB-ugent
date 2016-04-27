unique template common/ofed/opensm;

## enable service
variable OFED_IS_RDMA ?= is_defined(OFED_RELEASE_VERSION) && ! match(OFED_RELEASE_VERSION, "^mlnx");
variable OPENSM_SERVICE_NAME ?= {if(OFED_IS_RDMA) {"opensm";} else {"opensmd";};};
include 'components/chkconfig/config';
"/software/components/chkconfig/service" = {
    SELF[OPENSM_SERVICE_NAME] = dict("on", "", "startstop", true);
    SELF;
};

prefix "/software/packages";
"{opensm-libs}" = dict();
"{opensm}" = dict();


## topology engine
## minhop, updn, file, ftree, lash, dor
variable OPENSM_ROUTINGENGINE ?= "minhop";

variable OPENSM_MASTER_PRIORITY ?= 11;
variable OPENSM_PRIORITY ?= {
    max_prio=10;
    foreach(i;n;OPENSM_SERVERS) {
        if (match(FULL_HOSTNAME,format("^%s",n))) {
            return(max_prio - i);
        }
    };
    error(format("Not in OPENSM_SERVERS"));
};

## start options
include 'components/sysconfig/config';
"/software/components/sysconfig/files/opensm" = {
    if(OPENSM_PRIORITY >= OPENSM_MASTER_PRIORITY) {
        error(format("OPENSM_MASTER_PRIORITY %s must be higher than OPENSM_PRIORITY %s", OPENSM_MASTER_PRIORITY, OPENSM_PRIORITY));
    };
    if(OFED_IS_RDMA) {
        # for now
        dict("PRIORITY",format("'%s -A -R %s'",OPENSM_PRIORITY,OPENSM_ROUTINGENGINE))
    } else {
        dict("OPTIONS",format("'-p %s -E %s -A -R %s'", OPENSM_PRIORITY, OPENSM_MASTER_PRIORITY, OPENSM_ROUTINGENGINE));
    };
};

"/system/monitoring/hostgroups" = {
    append(SELF,"opensmd_servers");
    SELF;
};
