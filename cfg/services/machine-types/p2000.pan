unique template machine-types/p2000;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append(SELF,"HP_P2000");
    append(SELF,"HP_P2000_"+CLUSTER_NAME);
    SELF;
};
