unique template common/graphite-relay/config;

include 'common/graphite-relay/schema';

prefix "/software/components/metaconfig/services/{/etc/graphite-relay/graphite-relay.properties}";
"daemons" = dict("graphite-relay", "restart");
"module" = "graphite/graphite-relay";
"mode" = 0644;

"contents/relay/backendstrategy" = {
    strategy =  "Broadcast";
    if (value("/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/contents/relay/relay_method") == "consistent-hashing") {
        strategy =  "ConsistentHash";
    };
    format("graphite.relay.backend.strategy.%s",strategy);
};

"contents/relay/port" = value("/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/contents/relay/line_receiver_port");
"contents/relay/backends" = value("/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/contents/relay/destinations");
"contents/relay/overflowhandler" = 'graphite.relay.overflow.LoggingOverflowHandler';
"contents/overflow/directory" ?= "/var/spool/graphite-relay";


prefix "/software/components/metaconfig/services/{/etc/sysconfig/graphite-relay}";
"daemons" = dict("graphite-relay", "restart");
"module" = "tiny";
"mode" = 0644;

"contents/GR_USER" = "carbon";
"contents/CONF_FILE" = "/etc/graphite-relay/graphite-relay.properties";
"contents/LOG_CONF_FILE" = "/etc/graphite-relay/graphite-relay.log4j";
"contents/GR_JAVA_OPTS" = format("'-Xmx%sM -Xms%sM'", 1024, 1024);
include 'components/dirperm/config';
"/software/components/dirperm/paths" = append(dict(
    "path",    value("/software/components/metaconfig/services/{/etc/graphite-relay/graphite-relay.properties}/contents/overflow/directory"),
    "owner",   "carbon:carbon",
    "perm",    "0750",
    "type",    "d",
    ));
