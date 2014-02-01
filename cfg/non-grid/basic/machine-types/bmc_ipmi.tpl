unique template machine-types/bmc_ipmi;

include { 'machine-types/minimal' };

variable IPMI_HOSTGROUP ?= "IPMI";

"/system/monitoring/hostgroups" = {
    append(SELF,IPMI_HOSTGROUP);
    append(SELF,"BMC");
    append(SELF,"BMC_"+CLUSTER_NAME);
    SELF;
};

