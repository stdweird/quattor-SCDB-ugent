unique template common/repmgr/config;

variable REPMGR_CLUSTER ?= undef;
variable REPMGR_MASTER ?= undef;
variable REPMGR_HOSTS ?= undef; # a nlist of key=hostname, value = nlist with idx and ip

final variable IS_REPMGR_MASTER = {
    # the master can be in the STANDBY list
    # keep this one first
    if(match(FULL_HOSTNAME, format('^%s',REPMGR_MASTER))) {
        return(true);
    };

    foreach(hn;values;REPMGR_HOSTS) {
        if(match(FULL_HOSTNAME, format('^%s',hn))) {
            # a server in REPMGR_HOSTS, not the master
            return(false);
        };
    };

    error(format("No role could be determined (master of standby) for %s",FULL_HOSTNAME));
};

include 'common/repmgr/postgres';

include 'common/repmgr/schema';

prefix "/software/components/metaconfig/services/{/var/lib/pgsql/repmgr/repmgr.conf}";
"module" = "tiny";
"mode" = 0644;
"owner" = "postgres";
"group" = "postgres";

variable REPMGR_TRUSTED_IP = REPMGR_HOSTS[HOSTNAME]['ip'];

"contents/cluster"= REPMGR_CLUSTER;
# not supported in v1.2?
#"contents/node_name"= HOSTNAME;

"contents/node"= REPMGR_HOSTS[HOSTNAME]['idx'];
"contents/conninfo"=format("'host=%s user=repmgr dbname=repmgr'", REPMGR_TRUSTED_IP);

include 'common/nagios/checks/postgres_repmgr';
"/system/monitoring/hostgroups" = append('postgres_repmgr');
