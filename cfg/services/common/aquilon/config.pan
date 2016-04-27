unique template common/aquilon/config;

include 'common/aquilon/schema';

prefix "/software/components/metaconfig/services/{/etc/aqd.conf}";

"module" = "tiny";
"daemons" = dict("aqd", "restart");

prefix "/software/components/metaconfig/services/{/etc/aqd.conf}/contents";

"protocols/directory" = "/usr/lib/python2.6/site-packages/";
"database_postgresql/server" = "localhost";
"database/database_section" = "database_postgresql";
"broker/keytab" = "/etc/aquilon.cdb.keytab";
"broker/default_organization" = "UGent";
"broker/dsdb" = "/bin/echo";
"broker/dsdb_use_testdb" = true;
"broker/ant_home" = "/usr/share/ant";
"broker/ant" = "/usr/bin/ant";
"broker/ant_contrib_jar" = "/usr/share/java/ant/ant-contrib.jar";
"broker/compiletooldir" = "/usr/share/aquilon/build-xmls/10.0";
"broker/templatesdir" = AQD_TEMPLATES;
"broker/java_home" = "/usr";
"broker/sharedata" = "/dev/null";
"broker/logdir" = "/var/log/aquilon";
"broker/git_templates_url" = format("ssh://aquilon@%s/var/quattor/template-king",
                                    FULL_HOSTNAME);
"broker/mean" = "";
"broker/profilesdir" = value("/software/components/metaconfig/services/" +
                             "{/etc/httpd/conf.d/profiles.conf}" +
                             "/contents/vhosts/profiles/documentroot") +
        "/profiles";
"network_unknown/default_gateway_offset" = 254;
"network_ugent16/default_gateway_offset" = 126;
"kerberos/krb5_keytab" = "/etc/aquilon.cdb.keytab";
"kerberos/klist" = "/usr/bin/klist";
"kerberos/knc" = "/usr/bin/knc";
"panc/pan_compiler" = "/usr/lib/panc.jar";
"panc/transparent_gzip" = false;
"panc/xml_profiles" = false;
"panc/json_profiles" = true;
"panc/gzip_output" = true;


include 'components/dirperm/config';

"/software/components/dirperm/paths" = {
    append(dict(
               "path", "/var/log/aquilon",
               "owner", "aquilon:aquilon",
               "type", "d",
               "perm", "0750"));
    append(dict(
               "path", "/var/run/aquilon",
               "owner", "aquilon:aquilon",
               "type", "d",
               "perm", "0755"));
    append(dict(
               "path", AQD_TEMPLATES,
               "owner", "aquilon:aquilon",
               "type", "d",
               "perm", "0770"));
    append(dict("path", value("/software/components/metaconfig/services/" +
                               "{/etc/aqd.conf}/contents/broker/profilesdir"),
                 "owner", "aquilon:apache",
                 "type", "d",
                 "perm", "0750"));

    append(dict(
                   "path", value("/software/components/metaconfig/services/" +
                                 "{/etc/aqd.conf}/contents/broker/keytab"),
                   "owner", "root:aquilon",
                   "type", "f",
                   "perm", "0750"));

    foreach (i; admin; UGENT_ACTIVE_ADMINS) {
        append(dict(
                   "path", format("%s/%s", AQD_TEMPLATES, admin),
                   "owner", "aquilon:aquilon",
                   "type", "d",
                   "perm", "0770"));
    };
};


include 'common/aquilon/postgres';

include 'common/aquilon/accounts';
