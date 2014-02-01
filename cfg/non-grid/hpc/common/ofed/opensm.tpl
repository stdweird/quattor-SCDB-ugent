unique template common/ofed/opensm;

## enable service
variable OFED_IS_RDMA ?= false;
variable OPENSM_SERVICE_NAME ?= {if(OFED_IS_RDMA) {"opensm";} else {"opensmd";};};

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service" = {
    SELF[OPENSM_SERVICE_NAME] = nlist("on", "", "startstop", true);
    SELF;
};

prefix "/software/packages";
"{opensm-libs}" = nlist();
"{opensm}" = nlist();


## topology engine
## minhop, updn, file, ftree, lash, dor
variable OPENSM_ROUTINGENGINE ?= "minhop";

variable OPENSM_PRIORITY ?= {
    max_prio=15;
    foreach(i;n;OPENSM_SERVERS) {
        if (match(FULL_HOSTNAME,format("^%s",n))) {
            return(max_prio - i);
        }
    };
    error(format("Not in OPENSM_SERVERS"));
};

## start options
include { 'components/sysconfig/config' };
"/software/components/sysconfig/files/opensm" = {
    if(OFED_IS_RDMA) {
        # for now
        nlist("PRIORITY",format("'%s -R %s'",OPENSM_PRIORITY,OPENSM_ROUTINGENGINE))
    } else {
        nlist("OPTIONS",format("'-p %s -R %s'",OPENSM_PRIORITY,OPENSM_ROUTINGENGINE));
    };
};

"/system/monitoring/hostgroups" = {
    append(SELF,"opensmd_servers");
    SELF;
};
