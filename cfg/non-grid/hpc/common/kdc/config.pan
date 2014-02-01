unique template common/kdc/config;

final variable KDC_REALM ?= error("Define the KDC realm by now");

include 'common/kdc/schema';
include 'components/metaconfig/config';

prefix "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kadm5.acl}";

"mode" = 0600;
"module" = "kdc/acl";
"contents/acls/0/subject" = nlist("realm", KDC_REALM,
                             "primary", "*",
                             "instance", "admin");
"contents/acls/0/permissions" = list("*");

prefix "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kdc.conf}";

"mode" = 0600;
"module" = "kdc/config";
"daemon/0" = "krb5kdc";
"contents/defaults" = nlist();
"contents/realms" = nlist(KDC_REALM, nlist());
