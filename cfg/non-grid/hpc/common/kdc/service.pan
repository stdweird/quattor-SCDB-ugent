unique template common/kdc/service;

include 'common/kdc/config';
include 'common/kdc/packages';
include 'common/kdc/monitoring';
include 'common/krb5-client/service';
include 'common/kdc/backup';

include 'components/chkconfig/config';

"/software/components/chkconfig/service/krb5kdc" = nlist("on", "",
                                                         "startstop", true);
