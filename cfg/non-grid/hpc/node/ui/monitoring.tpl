unique template node/ui/monitoring;

"/system/monitoring/hostgroups" = {
    append(SELF,"login_nodes");
    append(SELF,"login_nodes_"+CLUSTER_NAME);
    SELF;
};