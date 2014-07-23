unique template common/quattor-server/secrets;

final variable QUATTOR_SERVER_SECRETS_PORT ?= 446;

include 'common/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/secrets.conf}/contents" = httpd_vhosts;

include 'common/httpd/service';

# nothing on default vhost on port 443, just remove it
"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents/vhosts/base" = null;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/secrets.conf}/contents/vhosts/secrets";

"ssl" = create("common/httpd/struct/basic_ssl");
"port" = QUATTOR_SERVER_SECRETS_PORT;
"ssl/verifyclient" = "require";
"documentroot" = "/var/www/secret";
"servername" = format("%s:%d", FULL_HOSTNAME, QUATTOR_SERVER_SECRETS_PORT);
'rewrite/rules/0/regexp' = '^/secure/?(.*)$';
'rewrite/rules/0/destination' = '/secure/%{REMOTE_HOST}/$1';
"rewrite/rules/0/flags/0" = "L";
'rewrite/maps/0/name' = "ACLmap";
'rewrite/maps/0/type' = "txt";
"rewrite/maps/0/source" = "/var/www/acl/ACLmap.txt";
"directories/0/ssl/require" = "%{SSL_CLIENT_S_DN_CN} eq %{REMOTE_HOST}";
"directories/0/name" = "/var/www/secret";
"hostnamelookups" = true;
"ssl/carevocationfile" = "/var/sindes/crl.pem";
"ip/0" = DB_IP[HOSTNAME];

"log/level" = "warn";
"log/error" = format("logs/%s_error_log", 'secrets');
"log/transfer" = format("logs/%s_access_log", 'secrets');
"log/custom"=append(nlist(
    "location", format("logs/%s_request_log", 'secrets'),
    "name", "ssl_combined"));

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/secrets.conf}";

"module" = "httpd/generic_server";
"daemon/0" = "httpd";

"contents/aliases" = list();
"contents/modules" = list();
"contents/listen/0" = nlist("name", DB_IP[HOSTNAME], "port", QUATTOR_SERVER_SECRETS_PORT);

include 'components/dirperm/config';

"/software/components/dirperm/paths" = append(nlist("owner", "root:root",
                                                    "path", "/var/www/secret/.git",
                                                    "perm", "0700",
                                                    "type", "d"));
