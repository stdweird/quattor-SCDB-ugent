unique template common/openldap/service;

include { "common/openldap/packages"};

include { 'common/openldap/config' };

"/system/monitoring/hostgroups" = append("openldap_servers");

include {if_exists('site/backup')};

"/software/components/chkconfig/service/slapd" = nlist(
    "startstop", true,
    "on", "");
