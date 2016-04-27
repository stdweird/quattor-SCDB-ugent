unique template common/nat/service;

variable NAT_PUBLIC_NETWORK ?= null;

include NAT_PUBLIC_NETWORK;

include 'common/nat/config';

include 'components/chkconfig/config';

include 'common/nat/logstash';

"/software/components/chkconfig/service/shorewall" = dict("on", "",
    "startstop", true);

include 'common/nat/monitoring';
