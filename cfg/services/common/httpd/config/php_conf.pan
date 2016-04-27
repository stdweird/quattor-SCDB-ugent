unique template common/httpd/config/php_conf;

include 'metaconfig/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/php.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/php.conf}";
"module" = format("httpd/%s/generic_server", METACONFIG_HTTPD_VERSION);
"daemons" = dict("httpd", "restart");

"/software/components/metaconfig/services/{/etc/httpd/conf.d/php.conf}/contents" = create('common/httpd/struct/php_conf');
