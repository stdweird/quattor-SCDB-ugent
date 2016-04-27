unique template common/ctdb/service;


## include if there is an IP configured on this node 
## that is part of the CTDB_NODES list
variable CTDB_NODES ?= undef;
variable CTDB_NODENAMES ?= undef;

include {
    if (! is_list(CTDB_NODES)) {
        error("including ctdb service and no CTDB_NODES list is defined");
    };
    
    base = "/system/network/interfaces";
    nics = value(base);
    foreach (k;v;nics) {
        if (exists(base+"/"+k+"/ip")) {
            ip=value(base+"/"+k+"/ip");
            foreach (k2;v2;CTDB_NODES) {
                if (v2 == ip) {
                    return('common/ctdb/config');
                };
            };
        };
    };
    
    ## If none of these match, try NODE_NAMES
    ## warning: NODE_NAMES expects to set the network later!!
    foreach(idx;nn;CTDB_NODENAMES) {
        if (match(FULL_HOSTNAME,nn)) {
                    return('common/ctdb/config');
        };
    };
};
