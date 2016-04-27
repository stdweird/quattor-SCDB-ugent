unique template common/httpd/config/httpd_conf;

include 'metaconfig/httpd/httpd_conf';

variable HTTPD_OS_FLAVOUR ?= format('el%s', RPM_BASE_FLAVOUR_VERSIONID);

"/software/components/metaconfig/services/{/etc/httpd/conf/httpd.conf}/contents" = create(format('common/httpd/struct/httpd_conf_%s', HTTPD_OS_FLAVOUR));

# the welcome.conf file shows an apache welcome message, we don't need this, so make it empty
# (removing it will make it reapear on next update)
prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/welcome.conf}";
"module" = "tiny";
"contents" = dict();
"daemons" = dict("httpd", "reload");
