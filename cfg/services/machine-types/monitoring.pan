template machine-types/monitoring;


include 'machine-types/core';

include 'common/postgresql/service';
include 'common/httpd/service';
include 'common/oncall/service';
include 'monitoring/icinga/service';

include 'common/pbsacc2db/service';
include 'common/pbsmon2php/service';
include 'common/postfix/service';

include 'machine-types/post/core';
