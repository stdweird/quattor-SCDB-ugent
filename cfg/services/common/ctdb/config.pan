unique template common/ctdb/config;

include 'common/ctdb/packages';

variable CTDB_SHAREDFS_BASEDIR ?= undef;

## List with public addresses/ranges + network adapters
## eg list("10.1.1.1/24 eth0")
variable CTDB_PUBLIC ?= undef;
## IPs of nodes that can be used
variable CTDB_NODES ?= undef;

## defaults
variable CTDB_DEBUGLEVEL ?= 2;

variable CTDB_MANAGES_SAMBA ?= false;
variable CTDB_MANAGES_NFS ?= false;
variable CTDB_NFS_GANESHA ?= false;

include 'metaconfig/ctdb/nodes';
include 'metaconfig/ctdb/public_addresses';
include 'metaconfig/ctdb/config';

"/software/components/metaconfig/services/{/etc/ctdb/nodes}/contents/nodelist" = CTDB_NODES;

prefix "/software/components/metaconfig/services/{/etc/ctdb/public_addresses}/contents";
"addresses" = {
    addrs = list();
    foreach(idx;addr;CTDB_PUBLIC) {
        adsp = split(' ', addr);
        append(addrs, dict(
            'network_name', adsp[0],
            'network_interface', adsp[1]
        ));
    };
    addrs;
};

variable CTDB_INIT_SYSCONFIG ?= '';
variable CTDB_INIT_ULIMIT_N ?= 10000;

"/software/components/metaconfig/services/{/etc/sysconfig/ctdb}/contents/service" = dict(
    "prologue",format("%s\nulimit -n %d",CTDB_INIT_SYSCONFIG,CTDB_INIT_ULIMIT_N),
    "ctdb_recovery_lock", CTDB_SHAREDFS_BASEDIR+"/lock/file",
    "ctdb_public_addresses", '/etc/ctdb/public_addresses',
    "ctdb_manages_samba", CTDB_MANAGES_SAMBA,
    "ctdb_manages_nfs", CTDB_MANAGES_NFS,
    "ctdb_debuglevel", CTDB_DEBUGLEVEL,
);

## start service
"/software/components/chkconfig/service/ctdb/on" = "";
"/software/components/chkconfig/service/ctdb/startstop" = true;

"/system/monitoring/hostgroups" = {
    append('storage_ctdb');
};
include {
    if (CTDB_MANAGES_NFS) {
        if(CTDB_NFS_GANESHA) {
            'common/ctdb/ganesha'
        } else {
            'common/ctdb/nfs'
        };
    };
};

include 'common/ctdb/logging';
