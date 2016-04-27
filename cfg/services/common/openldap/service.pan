unique template common/openldap/service;

include "common/openldap/packages";
include 'common/openldap/config';

"/system/monitoring/hostgroups" = append("openldap_servers");
include if_exists('site/backup');

"/software/components/chkconfig/service/slapd" = dict(
    "startstop", true,
    "on", "");

# Openldap rpm update also upgrades the config to the new format.
# Force component ldap to run so /etc/openldap/slapd.conf does not
# disappear.
"/software/components/spma/dependencies/post" = append("openldap");
"/software/components/openldap/dependencies/post" = append("chkconfig");
