unique template common/bacula/sd;


prefix "/software/packages";
"{bacula-storage}" = dict();
include 'components/chkconfig/config';
prefix "/software/components/chkconfig/service";
"bacula-sd" = dict(
    "startstop", true,
    "on", "");

include 'metaconfig/bacula/sd';

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-sd.conf}/contents";
