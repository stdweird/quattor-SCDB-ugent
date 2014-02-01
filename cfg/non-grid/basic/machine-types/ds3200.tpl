unique template machine-types/ds3200;

include { 'machine-types/minimal' };


"/system/monitoring/hostgroups" = {
    append(SELF,'IBM_DS3200');
    append(SELF,'IBM_DS3200_'+CLUSTER_NAME);
    SELF;
};
