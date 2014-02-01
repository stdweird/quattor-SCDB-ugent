unique template common/graphite-relay/service;

# setup graphite-relay instead of carbon relay;

include 'common/graphite-relay/packages';
include 'common/graphite-relay/config';

"/software/components/chkconfig/service/graphite-relay" = nlist("on", "", "startstop", true);
