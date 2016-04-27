unique template common/pacemaker/service;
include "common/pacemaker/rpms/config"+RPM_BASE_FLAVOUR;include 'common/pacemaker/config';
# Start heartbeat
#include { 'components/chkconfig/config' };
#"/software/components/chkconfig/service/heartbeat/on" = "";
#"/software/components/chkconfig/service/heartbeat/startstop" = true;
