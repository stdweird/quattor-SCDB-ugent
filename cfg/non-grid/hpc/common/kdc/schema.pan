@{
@}
declaration template common/kdc/schema;

type kdc_acl_principal = {
    "instance" ? string
    "realm" : string
    "primary" : string
};

type kdc_permissions = string with match(SELF, '^(a|c|d|i|l|m|p|s|x|\*)$');

type kdc_acl = {
    "subject" : kdc_acl_principal
    "permissions" : kdc_permissions[]
    "target" ? kdc_acl_principal
};

type kdc_acl_file = {
    "acls" : kdc_acl[]
};

bind "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kadm5.acl}/contents" = kdc_acl_file;

type kdc_defaults = {
    "ports" : type_port = 88
    "tcp_ports" : type_port = 884
};

type kdc_realm = {
    "acl_file" : string = "/var/kerberos/krb5kdc/kadm5.acl"
    "dict_file" : string = "/usr/share/dict/words"
    "admin_keytab" : string = "/var/kerberos/krb5kdc/krb5kdc/kadm5.keytab"
    "supported_enctypes" : string[] = list("aes256-cts:normal",
                                           "aes128-cts:normal",
                                           "des3-hmac-sha1:normal")
};

type kdc_conf_file = {
    "defaults" : kdc_defaults
    "realms" : kdc_realm{}
};

bind "/software/components/metaconfig/services/{/var/kerberos/krb5kdc/kdc.conf}/contents" = kdc_conf_file;
