unique template common/perfsonar/lookup/registration;

include 'components/chkconfig/config';
include 'common/perfsonar/lookup/registration/config';

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/ls_registration_daemon/etc/ls_registration_daemon.conf}/contents";

"ls_instance" = "http://localhost:9995/perfsonar_PS/services/hLS";
"site/0" = dict("site_name", "VSC",
    "site_location", "Gent",
    "address", FULL_HOSTNAME,
    "site_project", list("VSC"),
    "service", list(dict("type", "bwctl"),
    dict("type", "owamp")));

prefix "/software/components/chkconfig/service";

"ls_registration_daemon" = dict("on", "", "startstop", true);
