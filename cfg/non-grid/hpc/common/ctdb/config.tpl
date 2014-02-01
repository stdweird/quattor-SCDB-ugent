unique template common/ctdb/config;

include 'common/ctdb/packages';

variable CTDB_SHAREDFS_BASEDIR ?= undef;

## List with public addresses/ranges + network adapters
## eg list("10.1.1.1/24 eth0")
variable CTDB_PUBLIC ?= undef;
## IPs of nodes that can be used
variable CTDB_NODES ?= undef;

## defaults
variable CTDB_PUBLIC_ADDRESSES_FILE ?= "/etc/ctdb/public_addresses";

variable CTDB_DEBUGLEVEL ?= 2;

variable CTDB_MANAGES_SAMBA ?= false;
variable CTDB_MANAGES_NFS ?= false;
variable CTDB_NFS_GANESHA ?= false;

## for now, no ctdb component to manage these files
variable CONTENT = {
    txt ='';
    if (! is_list(CTDB_NODES)) {
        error("CTDB_NODES not a list");
    };
    foreach(k;v;CTDB_NODES) {
        txt = txt + v + "\n";
    };
    txt;
};
'/software/components/filecopy/services' =
  npush(escape("/etc/ctdb/nodes"),
        nlist('config',CONTENT,
              'owner','root:root',
              'perms', '0755'));

variable CONTENT = {
    txt ='';
    if (! is_list(CTDB_PUBLIC)) {
        error("CTDB_PUBLIC not a list");
    };
    foreach(k;v;CTDB_PUBLIC) {
        txt = txt + v + "\n";
    };
    txt;
};
'/software/components/filecopy/services' =
  npush(escape(CTDB_PUBLIC_ADDRESSES_FILE),
        nlist('config',CONTENT,
              'owner','root:root',
              'perms', '0755'));

variable CTDB_INIT_SYSCONFIG ?= '';
variable CTDB_INIT_ULIMIT_N ?= 10000;
include {'components/sysconfig/config'};
"/software/components/sysconfig/files/ctdb" = nlist(
    "prologue",format("%s\nulimit -n %d",CTDB_INIT_SYSCONFIG,CTDB_INIT_ULIMIT_N),
    "CTDB_RECOVERY_LOCK",CTDB_SHAREDFS_BASEDIR+"/lock/file",
    "CTDB_PUBLIC_ADDRESSES",CTDB_PUBLIC_ADDRESSES_FILE,
    "CTDB_MANAGES_SAMBA",booltoyesno(CTDB_MANAGES_SAMBA),
    "CTDB_MANAGES_NFS",booltoyesno(CTDB_MANAGES_NFS),
    "CTDB_DEBUGLEVEL",to_string(CTDB_DEBUGLEVEL),
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

include {'common/ctdb/logging'};