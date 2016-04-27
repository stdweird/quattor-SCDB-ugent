unique template common/graphite/carbon/config;

prefix "/software/packages";
"{python-carbon}" = dict();

include 'metaconfig/graphite/config';

variable CARBON_SERVICE_CACHE ?= if(GRAPHITE_CARBON_CACHE) {"on"} else {"off"};
variable CARBON_SERVICE_RELAY ?= if(GRAPHITE_CARBON_RELAY) {"on"} else {"off"};
variable CARBON_SERVICE_AGGREGATOR ?= if(GRAPHITE_CARBON_AGGREGATOR) {"on"} else {"off"};

include {if(GRAPHITE_CARBON_CACHE) {'common/graphite/carbon/cache'}};
include {if(GRAPHITE_CARBON_RELAY) {'common/graphite/carbon/relay'}};
include {if(GRAPHITE_CARBON_AGGREGATOR) {'common/graphite/carbon/aggregator'}};

prefix "/software/components/chkconfig/service";
"carbon-cache" = dict(CARBON_SERVICE_CACHE, "", "startstop", true);
"carbon-relay" = dict(CARBON_SERVICE_RELAY, "", "startstop", true);
"carbon-aggregator" = dict(CARBON_SERVICE_AGGREGATOR, "", "startstop", true);

include 'common/graphite/carbon/user';
