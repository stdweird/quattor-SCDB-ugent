unique template common/carbon-relay-ng/config;

variable CARBON_SPOOLDIR ?= "/var/spool/carbon-relay-ng";

include 'metaconfig/carbon-relay-ng/config';
prefix "/software/components/metaconfig/services/{/etc/carbon-relay-ng.ini}/contents";
'instance' = CLUSTER_NAME;
'listen_addr' = "0.0.0.0:2003";
'admin_addr' = "localhost:2004";
'http_addr' = "localhost:8081";
'spool_dir' = CARBON_SPOOLDIR;
'log_level' = "notice";
'instrumentation/graphite_addr' = "localhost:2003";
'instrumentation/graphite_interval' = 1000;
'init/0/addRoute' = dict(
    'type', 'sendAllMatch',
    'key', 'carbon-default',
    'dest', list(dict(
        'addr', 'tangela2.ugent.be:2013',
        'opts', dict(
            'spool', false, 
            'pickle', false,
            ),
        )),
    );
include 'components/dirperm/config';
"/software/components/dirperm/paths" = append(dict(
    "path",    CARBON_SPOOLDIR,
    "owner",   "carbon:carbon",
    "perm",    "0750",
    "type",    "d",
    ));

"/software/components/dirperm/paths" = append(dict(
    "path",    "/var/run/carbon-relay-ng",
    "owner",   "carbon:carbon",
    "perm",    "0750",
    "type",    "d",
    ));
