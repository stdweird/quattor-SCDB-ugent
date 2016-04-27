unique template common/elasticsearch/service;

include 'common/elasticsearch/config';
include 'common/elasticsearch/monitoring/nrpe';
include 'common/elasticsearch/packages';

include 'components/chkconfig/config';
"/software/components/chkconfig/service/elasticsearch" = dict("on", "", "startstop", true);

"/system/monitoring/hostgroups" = append("elasticsearch");

include 'common/elasticsearch/directories';
