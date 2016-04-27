unique template machine-types/switch;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append(SELF,"switches");
    append(SELF,"switches_"+CLUSTER_NAME);
    SELF;
};
