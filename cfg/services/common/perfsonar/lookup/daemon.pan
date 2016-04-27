unique template common/perfsonar/lookup/daemon;
include 'components/chkconfig/config';
include 'common/perfsonar/lookup/daemon/config';
prefix "/software/components/chkconfig/service";

"lookup_service" = dict("on", "", "startstop", true);

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/lookup_service/etc/daemon.conf}/contents/port/0/endpoint/0";
"name" = "/perfsonar_PS/services/hLS";
"gls/0/service_name" = "PerfSONAR gLS at UGent for VSC";
"gls/0/service_description" = "VSC lookup service at UGent";

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/lookup_service/etc/daemon.conf}/contents";

"port/0/portnum" = 9995;
