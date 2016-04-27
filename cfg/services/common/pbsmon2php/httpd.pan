unique template common/pbsmon2php/httpd;

# add php.conf
include 'common/httpd/config/php_conf';

# pbsmon2php.conf
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}";
"module" = "httpd/generic_server";
"daemons" = dict("httpd", "restart");

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}/contents";

"aliases" = append(dict(
    "url", "/pbsmon2php",
    "destination", "/var/www/pbsmon2php",
));

"directories" = append(dict(
    "name", "/var/www/pbsmon2php",
    "auth", dict(
        "name", "Icinga Access",
        "type", "Basic",
        "basicprovider", "file",
        "userfile", "/etc/icinga/htpasswd.users",
        "require", dict("type", "valid-user"),
        ),
    "access", dict(
        "allowoverride", list("None"),
        "order", list("allow","deny"),
        "allow",list("all"),
        ),
));
