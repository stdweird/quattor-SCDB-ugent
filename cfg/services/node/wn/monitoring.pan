unique template node/wn/monitoring;

"/system/monitoring/hostgroups" = {
    if (! (is_defined(IGNORE_WN_MONITORING) && IGNORE_WN_MONITORING)) {
        append(SELF,"worker_nodes");
        append(SELF,"worker_nodes_"+CLUSTER_NAME);
    };
    SELF;
};
