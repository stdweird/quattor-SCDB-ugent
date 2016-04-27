unique template node/ce/monitoring;

"/system/monitoring/hostgroups" = {
    append(SELF,"master_nodes");
    append(SELF,"master_nodes_"+CLUSTER_NAME);
    SELF;
};
