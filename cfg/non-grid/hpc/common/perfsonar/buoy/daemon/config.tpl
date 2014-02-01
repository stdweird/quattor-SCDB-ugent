unique template common/perfsonar/buoy/daemon/config;

include {'common/perfsonar/buoy/daemon/schema'};

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/daemon.conf}";

"daemon/0" = "perfsonarbuoy_ma";
"owner" = "root";
"group" = "root";
"module" = "perfsonar/ma";