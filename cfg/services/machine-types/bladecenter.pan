unique template machine-types/bladecenter;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append(SELF,"IBM_Bladecenters");
    append(SELF,"IBM_Bladecenters_"+CLUSTER_NAME);
    SELF;
};
