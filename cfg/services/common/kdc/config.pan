unique template common/kdc/config;

final variable KDC_REALM ?= error("Define the KDC realm by now");

include 'components/metaconfig/config';

include 'metaconfig/kerberos/kdc_acl';

prefix "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kadm5.acl}/contents";
"acls/0/subject" = dict(
    "realm", KDC_REALM,
    "primary", "*",
    "instance", "admin",
    );
"acls/0/permissions" = list("*");

include 'metaconfig/kerberos/kdc_conf';
prefix "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kdc.conf}/contents";
"realms" = dict(KDC_REALM, dict());
