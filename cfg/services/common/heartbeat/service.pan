unique template common/heartbeat/service;
include "common/heartbeat/rpms/config"+RPM_BASE_FLAVOUR;
# Start heartbeat
#include { 'components/chkconfig/config' };
#"/software/components/chkconfig/service/heartbeat/on" = "";
#"/software/components/chkconfig/service/heartbeat/startstop" = true;
