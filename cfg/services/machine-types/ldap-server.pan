template machine-types/ldap-server;


include 'machine-types/core';

include 'common/openldap/service';
variable LDAP_LOCAL_SITE ?= null;
include LDAP_LOCAL_SITE;
# FIX FOR LEAKING MEWTWO VALUES
"/software/components/accounts/groups/icingacmd" =
  dict("gid", 49);

"/system/monitoring/hostgroups" = append("ldap_masters");

include 'machine-types/post/core';
