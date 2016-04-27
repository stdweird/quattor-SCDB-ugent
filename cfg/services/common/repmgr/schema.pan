declaration template common/repmgr/schema;

type type_repmgr_config = {
    "cluster" : string
    "node" : long(0..)
    "node_name" ? string
    "conninfo" : string
};

bind "/software/components/metaconfig/services/{/var/lib/pgsql/repmgr/repmgr.conf}/contents" = type_repmgr_config;
