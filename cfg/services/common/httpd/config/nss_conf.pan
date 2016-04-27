unique template common/httpd/config/nss_conf;

include 'metaconfig/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}";
"module" = format("httpd/%s/generic_server", METACONFIG_HTTPD_VERSION);
"daemons" = dict("httpd", "restart");

variable HTTPD_OS_FLAVOUR ?= format('el%s', RPM_BASE_FLAVOUR_VERSIONID);

"/tmp/httpd" = create(format('common/httpd/struct/nss_conf_%s', HTTPD_OS_FLAVOUR));

"/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}/contents" = value("/tmp/httpd");
