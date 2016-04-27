unique template machine-types/idrac_ipmi;

include 'machine-types/minimal';

variable IPMI_HOSTGROUP ?= "IPMI20";

"/system/monitoring/hostgroups" = {
    append(SELF,IPMI_HOSTGROUP);
    append(SELF,"IDRAC");
    append(SELF,"IDRAC_"+CLUSTER_NAME);
    SELF;
};
