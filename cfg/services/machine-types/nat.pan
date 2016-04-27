unique template machine-types/nat;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append(SELF,"nat_nodes");
    SELF;
};
