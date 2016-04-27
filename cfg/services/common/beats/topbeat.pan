unique template common/beats/topbeat;

include 'components/chkconfig/config';
include 'components/metaconfig/config';

"/system/monitoring/hostgroups" = append("topbeat");

"/software/components/chkconfig/service/topbeat" = dict(
    "on", "",
    "startstop", true);

include 'metaconfig/beats/filebeat';
include 'common/beats/logstash';
include 'common/beats/logging_varlog';

prefix "/software/packages";
"{topbeat}" = dict();
