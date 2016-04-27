unique template common/aquilon/keytab;

include 'common/download/service';

prefix "/software/components/download/files";

"{/etc/krb5.keytab}" = create("common/download/auth",
                              "href", "secure/keytab",
                              "owner", "root",
                              "group", "aquilon",
                              "perm", "0640");
