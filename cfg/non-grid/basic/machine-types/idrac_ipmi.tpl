unique template machine-types/idrac_ipmi;

include { 'machine-types/minimal' };

"/system/monitoring/hostgroups" = {
    append(SELF,"IPMI");
    append(SELF,"IDRAC");
    append(SELF,"IDRAC_"+CLUSTER_NAME);
    SELF;
};

