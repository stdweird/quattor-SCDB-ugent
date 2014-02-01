unique template common/perfsonar/buoy/daemon;

include {'common/perfsonar/buoy/daemon/config'};
include {'common/perfsonar/bwctl/config'};

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/daemon.conf}/contents";

"ports/0/endpoint/0/name" = "/perfsonar_PS/services/pSB";
"ports/0/endpoint/0/buoy/service_description" = "PerfSONAR measurement archive (MA) for VSC";
