unique template common/aquilon/service;

final variable AQD_TEMPLATES ?= '/var/lib/templates';

include 'common/aquilon/keytab';
include 'common/aquilon/packages';
include 'common/aquilon/monitoring';
include 'common/krb5-client/service';

include 'common/aquilon/config';

include 'components/chkconfig/config';

"/software/components/chkconfig/service/aqd" = nlist("on", "");


final "/system/monitoring/hostgroups" = append("aquilon");
valid "/system/monitoring/hostgroups" = {
    foreach(i; h; SELF) {
        if (h == 'aquilon') {
            return(true);
        };
    };
    error ("Not here, wtf");
};
