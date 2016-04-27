@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template setting up the basics for a WSGI Application
}

unique template common/wsgi/config;
include 'components/metaconfig/config';
include 'common/wsgi/packages';
variable PASSENGER_POOL_SIZE ?= 10;

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}";

"mode" = 0644;
"owner" = "root";
"group" = "root";
"daemons" = dict("httpd", "restart");
"module" = "httpd/generic_server";

"contents/modules" = append(dict(
    "name", "wsgi_module",
    "path", "modules/mod_wsgi.so",
));
