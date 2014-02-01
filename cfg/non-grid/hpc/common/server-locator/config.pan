unique template common/server-locator/config;

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/server-locator.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/server-locator.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/server-locator.conf}/contents";

"aliases" = append(nlist(
    "url", "/server-locator",
    "destination", "/var/www/server-locator",
));

"directories" = append(nlist(
    "name", "/var/www/server-locator",
    "auth", nlist(
        "name", "Server-locator Access",
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
   
   