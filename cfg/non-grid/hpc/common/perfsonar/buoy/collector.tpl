unique template common/perfsonar/buoy/collector;

prefix "/software/components/chkconfig/service";

"perfsonarbuoy_bw_collector" = nlist("off", "", "startstop", true);
"perfsonarbuoy_owp_collector" = nlist("off", "", "startstop", true);
"perfsonarbuoy_ma" = nlist("off", "", "startstop", true);
"mysqld" = nlist("on", "", "startstop", true);

"/system/monitoring/hostgroups" = append("buoy_ma");
