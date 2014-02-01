unique template common/rpcidmapd/config;

include 'common/rpcidmapd/packages';

include {'components/metaconfig/config'};
include {'common/rpcidmapd/schema'};

bind "/software/components/metaconfig/services/{/etc/idmapd.conf}/contents" = rpcidmapd_config;

prefix "/software/components/metaconfig/services/{/etc/idmapd.conf}";
"daemon/0" = { if(RPCIDMAPD_RUNNING) {"rpcidmapd"} else { null;}};
"module" = "rpcidmapd/main";

