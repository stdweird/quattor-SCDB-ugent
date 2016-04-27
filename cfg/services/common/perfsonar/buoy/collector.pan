unique template common/perfsonar/buoy/collector;

prefix "/software/components/chkconfig/service";

"perfsonarbuoy_bw_collector" = dict("off", "", "startstop", true);
"perfsonarbuoy_owp_collector" = dict("off", "", "startstop", true);
"perfsonarbuoy_ma" = dict("off", "", "startstop", true);
"mysqld" = dict("on", "", "startstop", true);

"/system/monitoring/hostgroups" = append("buoy_ma");
