unique template common/mongodb/service;

include 'components/accounts/config';
include 'components/chkconfig/config';
include 'common/mongodb/packages';
include 'common/mongodb/schema';
include 'components/metaconfig/config';

include 'common/mongodb/config';

"/software/components/accounts/kept_users/mongod" = '';
"/software/components/accounts/kept_groups/mongod" = '';

"/system/monitoring/hostgroups" = append("mongodb_servers");

include 'components/chkconfig/config';

"/software/components/chkconfig/service/mongod" = dict(
    "on", "",
    "startstop", true);

variable OS_REPOSITORY_LIST = append("mongodb");
