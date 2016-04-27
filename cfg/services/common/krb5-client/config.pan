unique template common/krb5-client/config;

include 'metaconfig/kerberos/krb5_conf';

prefix "/software/components/metaconfig/services/{/etc/krb5.conf}/contents";
"logging" = dict();
"libdefaults/default_realm" = KDC_REALM;
"realms" = dict(
    KDC_REALM,
    dict(
        "kdc", KDC_SERVER,
        "admin_server", KDC_SERVER,
    ));
"domain_realms" = dict(DEFAULT_DOMAIN, KDC_REALM);
