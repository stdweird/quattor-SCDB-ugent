unique template common/elasticsearch/service;

include {'common/elasticsearch/config'};
include {'components/chkconfig/config'};
include {'common/elasticsearch/schema'};
include {'common/elasticsearch/monitoring/nrpe'};
include 'common/elasticsearch/packages';

"/software/components/chkconfig/service/elasticsearch" = nlist("on", "", "startstop", true);

"/system/monitoring/hostgroups" = append("elasticsearch");

include 'common/elasticsearch/directories';
