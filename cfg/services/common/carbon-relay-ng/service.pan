unique template common/carbon-relay-ng/service;

include 'common/graphite/carbon/user';

include 'common/carbon-relay-ng/config';

prefix '/software/packages';
"{carbon-relay-ng}" = dict(); 

"/software/components/chkconfig/service/carbon-relay-ng" = dict("on", "", "startstop", true);
