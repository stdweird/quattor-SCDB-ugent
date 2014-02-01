unique template common/pbsmon2php-users/service;

"/software/packages/{pbsmon2php-users-ugent}" = nlist();

include 'components/dirperm/config';

"/software/components/dirperm/paths" = append(
    nlist("path", "/var/www/pbsmon2php-users",
	  "type", "d",
	  "owner", "root",
	  "perm", "0755"));

include 'components/cron/config';

"/software/components/cron/entries" = append(
    nlist("command", "/usr/bin/get_user_site.sh",
	  "name", "pbsmon-users",
	  "comment", "PBSmon users display",
	  "user", "root",
	  "group", "root",
	  "timing", nlist("minute", "*/3")));

include 'components/filecopy/config';

"/software/components/filecopy/services/{/etc/pbsmon2php/users}" = nlist(
    "config", format("PBSMON_USER=\"%s\"\nPBSMON_PASSWD=\"%s\"\nJSONURL=\"%s\"\n",
	"icingaadmin", PBSMON_PASSWD,
	"https://mewtwo.ugent.be/pbsmon2php/json/pbsmon_json_"),
    "perms", "0400");

# add pbsmon2php-users.conf
include 'common/httpd/schema';
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/pbsmon2php-users.conf}/contents";
"aliases" = list(
    nlist(
        "url", "/pbsmon2php",
        "destination", "/var/www/pbsmon2php-users",
        )
);
"directories" = list(
    nlist(
        "name", "/var/www/pbsmon2php-users",
        "access", nlist(
            "allowoverride", list("None"),
            "order", list('allow','deny'),
            "allow", list("all"),
            ),
        ),
);
