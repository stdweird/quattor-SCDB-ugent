unique template common/rpcidmapd/config;

include 'common/rpcidmapd/packages';

include 'metaconfig/rpcidmapd/config';

prefix "/software/components/metaconfig/services/{/etc/idmapd.conf}";
"daemons" = { if(RPCIDMAPD_RUNNING) {SELF} else { null;}};
