declaration template common/perfsonar/bwctl/schema;

type bwctl_server = {
    "user" : string = "bwctl"
    "group" : string = "bwctl"
    "iperf_port" : type_port
    "nuttcp_port" : type_port
    "control_timeout" : long(0..) = 7200
    "allow_unsync": boolean = false
};

type bwctl_client = {
    "iperf_port" ? type_port
    "control_timeout" : long = 7200
    "allow_unsync" : boolean = false
};

type limitname = string with exists("/software/components/metaconfig/services/{/etc/bwctld/bwctld.limits}/contents/limit/" + SELF) ||
    error(SELF + " must be an existing bwctl limit specification (watch out for cyclic references!");

type bwctl_limit = {
    "parent" ? limitname
    "duration" ? long(0..)
    "allow_tcp" ? boolean
    "allow_udp" ? boolean
    "bandwidth" ? long
    "allow_open_mode" ? boolean
};

type bwctl_assign = {
    "network" : type_network_name
    "restrictions" : limitname
};

type bwctl_limits = {
    "assign" : bwctl_assign[]
    "limit" : bwctl_limit{}
};

bind "/software/components/metaconfig/services/{/etc/bwctld/bwctld.conf}/contents" = bwctl_server;

bind "/software/components/metaconfig/services/{/var/lib/bwctl/.bwctlrc}/contents" = bwctl_client;

bind "/software/components/metaconfig/services/{/etc/bwctld/bwctld.limits}/contents" = bwctl_limits;

bind "/software/components/metaconfig/services/{/var/lib/perfsonar/.bwctlrc}/contents" = bwctl_client;
