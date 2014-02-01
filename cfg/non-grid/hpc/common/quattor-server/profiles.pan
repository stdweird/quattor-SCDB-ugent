unique template common/quattor-server/profiles;

final variable QUATTOR_SERVER_PROFILE_PORT ?= 444;

include 'common/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/profiles.conf}/contents" = httpd_vhosts;

include 'common/httpd/service';

# nothing on default vhost on port 443, just remove it
"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents/vhosts/base" = null;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/profiles.conf}/contents/vhosts/profiles";

"ssl" = create("common/httpd/struct/basic_ssl");
"port" = QUATTOR_SERVER_PROFILE_PORT;
"documentroot" = "/var/www/https";
"servername" = format("%s:%d", FULL_HOSTNAME, QUATTOR_SERVER_PROFILE_PORT);
"rewrite/rules/0/conditions/0" = nlist("test", "${ACLmap:%{REMOTE_HOST}|NO}",
    "pattern", "NO");
'rewrite/rules/0/regexp' = '^/profiles/.*\.(xml|json)(\.gz)?$';
'rewrite/rules/0/destination' = '/profiles/%{REMOTE_HOST}.$1$2';
"rewrite/rules/0/flags/0" = "L";
'rewrite/maps/0/name' = "ACLmap";
'rewrite/maps/0/type' = "txt";
"rewrite/maps/0/source" = "/var/www/acl/ACLmap.txt";
"directories/0/ssl/require" = "%{SSL_CLIENT_S_DN_CN} eq %{REMOTE_HOST}";
"directories/0/name" = "/var/www/https/profiles";
"directories/0/ssl/verifyclient" = "require";
"hostnamelookups" = true;
"ssl/carevocationfile" = "/var/sindes/crl.pem";
"ip/0" = DB_IP[HOSTNAME];
"locations/0/name" = "/newcert";
"locations/0/handler/set" = "modperl";
"locations/0/perl/responsehandler" = "SINDES::GetCertificate2";
"perl/options" = list("+Parent");
"perl/modules/0" = "SINDES::GetCertificate";
"perl/modules/1" = "SINDES::GetCertificate2";
"perl/switches/0" = "-I/usr/lib/perl";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/profiles.conf}";

"module" = "httpd/generic_server";
"daemon/0" = "httpd";

"contents/aliases" = list();
"contents/modules" = list();
"contents/encodings/0/mime" = "x-gzip";
"contents/encodings/0/extensions" = list(".gz", ".tgz");
"contents/listen/0" = nlist("name", DB_IP[HOSTNAME], "port", QUATTOR_SERVER_PROFILE_PORT);


bind "/software/components/metaconfig/services/{/var/www/acl/ACLmap.txt}/contents" = boolean{};

prefix "/software/components/metaconfig/services/{/var/www/acl/ACLmap.txt}";

"module" = "general";
"contents" = nlist(FULL_HOSTNAME, true);
