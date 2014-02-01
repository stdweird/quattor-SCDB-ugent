unique template common/httpd/config/ssl_conf;

include 'common/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

variable HTTPD_OS_FLAVOUR ?= 'el6';

# reset
"/tmp/httpd" = create(format('common/httpd/struct/ssl_conf_%s', HTTPD_OS_FLAVOUR));

# using public ugent certificates by default
variable HTTPD_SSL_CONF_PUBLIC_CERT ?= true;
"/tmp/httpd/vhosts/base/ssl" = {
    if(HTTPD_SSL_CONF_PUBLIC_CERT) {
        tmp=create('common/httpd/struct/public_vhost');
        SELF["cacertificatefile"]=tmp['ssl']["cacertificatefile"];
        SELF["certificatefile"]=tmp['ssl']["certificatefile"];
        SELF["certificatekeyfile"]=tmp['ssl']["certificatekeyfile"];
    };
    SELF;
};

"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents" = value("/tmp/httpd");
