unique template common/beats/filebeat;

include 'components/chkconfig/config';
include 'components/metaconfig/config';

"/system/monitoring/hostgroups" = append("filebeat");

"/software/components/chkconfig/service/filebeat" = dict(
    "on", "",
    "startstop", true);

include 'metaconfig/beats/filebeat';
include 'common/beats/logstash';
include 'common/beats/logging_varlog';

prefix "/software/packages";
"{filebeat}" = dict();
