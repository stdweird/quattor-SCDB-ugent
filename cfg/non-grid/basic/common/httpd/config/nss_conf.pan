unique template common/httpd/config/nss_conf;

include 'common/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

variable HTTPD_OS_FLAVOUR ?= 'el6';

"/tmp/httpd" = create(format('common/httpd/struct/nss_conf_%s', HTTPD_OS_FLAVOUR));

"/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}/contents" = value("/tmp/httpd");

