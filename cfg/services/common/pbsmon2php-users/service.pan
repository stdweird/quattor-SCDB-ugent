unique template common/pbsmon2php-users/service;

"/software/packages/{pbsmon2php-users-ugent}" = dict();

include 'components/dirperm/config';

"/software/components/dirperm/paths" = append(
    dict("path", "/var/www/pbsmon2php-users",
	  "type", "d",
	  "owner", "root",
	  "perm", "0755"));

include 'components/cron/config';

"/software/components/cron/entries" = append(
    dict("command", "/usr/bin/get_user_site.sh",
	  "name", "pbsmon-users",
	  "comment", "PBSmon users display",
	  "user", "root",
	  "group", "root",
	  "timing", dict("minute", "*/3")));

include 'components/filecopy/config';

"/software/components/filecopy/services/{/etc/pbsmon2php/users}" = dict(
    "config", format("PBSMON_USER=\"%s\"\nPBSMON_PASSWD=\"%s\"\nJSONURL=\"%s\"\n",
	"icingaadmin", PBSMON_PASSWD,
	"https://mewtwo.ugent.be/pbsmon2php/json/pbsmon_json_"),
    "perms", "0400");

# add pbsmon2php-users.conf
include 'metaconfig/httpd/schema';
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}";
"module" = "httpd/generic_server";
"daemons" = dict("httpd", "restart");

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}/contents";
"aliases" = list(
    dict(
        "url", "/pbsmon2php",
        "destination", "/var/www/pbsmon2php-users",
        )
);
"directories" = list(
    dict(
        "name", "/var/www/pbsmon2php-users",
        "access", dict(
            "allowoverride", list("None"),
            "order", list('allow','deny'),
            "allow", list("all"),
            ),
        ),
);
