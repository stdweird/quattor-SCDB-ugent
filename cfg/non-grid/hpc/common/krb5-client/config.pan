unique template common/krb5-client/config;

include 'common/krb5-client/schema';

prefix "/software/components/metaconfig/services/{/etc/krb5.conf}";

"module" = "kerberos/client";

"contents/logging" = nlist();
"contents/libdefaults/default_realm" = KDC_REALM;
"contents/realms" = nlist(KDC_REALM,
                 nlist("kdc", KDC_SERVER,
                       "admin_server", KDC_SERVER));
"contents/domain_realms" = nlist(DEFAULT_DOMAIN, KDC_REALM);
