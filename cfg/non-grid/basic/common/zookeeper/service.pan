unique template common/zookeeper/service;

variable ZOOKEEPER_SERVERS ?= undef; # list with fqdn zookeeper servers

# install the zookeeper-server; see client for client rpms etc
include 'common/zookeeper/config';
include 'common/zookeeper/packages';

include 'common/zookeeper/client';

include {'components/chkconfig/config'};
prefix "/software/components/chkconfig/service";
"zookeeper-server" = nlist(
    "startstop", true,
    "on", "");
