unique template common/yum-mirror/httpd;

include 'common/httpd/schema';

# drop ssl.conf 443 host, use the one from mirroring.conf
"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents/vhosts/base" = null;

variable YUM_PROXY_IP_ADDRESSES ?= list("0.0.0.0");
variable YUM_MIRROR_PROXIES ?= list("127.0.0.1");

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/mirroring.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/mirroring.conf}/contents/";

"aliases" = list();
"modules" = list();

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/mirroring.conf}/contents/vhosts";

"default" = create("common/httpd/struct/public_vhost",
    "servername", FULL_HOSTNAME,
    "documentroot", "/var/www/packages/restricted");
"default/directories/0" = nlist(
    "name", "/var/www/packages/restricted",
    "options", list("+indexes"),
    "enablesendfile", false,
    "access", nlist(
        "order", list("allow","deny"),
        "allow", YUM_MIRROR_PROXIES));
"default/ip" =  YUM_PROXY_IP_ADDRESSES;
"default/port" = 80;
"default/ssl" = null;

"restricted_ugent" = create("common/httpd/struct/public_vhost",
    "documentroot", "/var/www/packages/restricted");

"public" = create("common/httpd/struct/default_vhost",
    "servername", FULL_HOSTNAME,
    "port", 80,
    "ip", list("0.0.0.0"),
    "documentroot", "/var/www/packages/public");
"public/ssl" = null;
"public/directories/0" = nlist(
    "options", list("+indexes"),
    "enablesendfile", false,
    "name", "/var/www/packages/public");

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/mirroring.conf}/contents";

"aliases/0/url" = "/baseos";
"aliases/0/destination" = "/var/www/packages/baseos";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/mirroring.conf}";

"daemon/0" = "httpd";
"module" = "httpd/generic_server";
