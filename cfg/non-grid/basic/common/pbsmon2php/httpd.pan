unique template common/pbsmon2php/httpd;

# add php.conf
include 'common/httpd/config/php_conf';

# pbsmon2php.conf
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php.conf}/contents";

"aliases" = append(nlist(
    "url", "/pbsmon2php",
    "destination", "/var/www/pbsmon2php",
));

"directories" = append(nlist(
    "name", "/var/www/pbsmon2php",
    "auth", nlist(
        "name", "Icinga Access",
        "type", "Basic",
        "basicprovider", "file",
        "userfile", "/etc/icinga/htpasswd.users",
        "require", nlist("type", "valid-user"),
        ),
    "access", nlist(
        "allowoverride", list("None"),
        "order", list("allow","deny"),
        "allow",list("all"),
        ),
));
   
