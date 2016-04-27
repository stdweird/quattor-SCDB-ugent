unique template machine-types/dell_blade_chassis;
include 'machine-types/minimal';

"/system/monitoring/hostgroups" = {
    append(SELF, 'dell_blade_chassis');
    append(SELF,'dell_blade_chassis_'+CLUSTER_NAME);
    SELF;
};
