unique template common/httpd/service;

# can be used to check if this is already included before
#   will throw error otherwise (trying to modify the final global variable)
final variable HTTPD_SERVICE_INCLUDED = true;

variable IS_PUBLIC_HTTPD ?= false;

"/system/monitoring/hostgroups" = append("httpd_servers");

#define user
include 'components/accounts/config';
prefix "/software/components/accounts/groups";
"apache/gid" = 48;
"icingacmd/gid" = 49;
"icinga/gid" = 500;
"sindes/gid" = 480;

"/software/components/accounts/users/apache" = dict(
  "uid", 48,
  "groups", list("apache", "icingacmd", "icinga"),
  "comment","apache",
  "shell", "/sbin/nologin",
  "homeDir", "/var/www"
);
include 'common/httpd/packages';
# Start Apache
include 'components/chkconfig/config';
'/software/components/chkconfig/service/httpd' = dict("on", "",
						       "startstop", true);

"/software/components/chkconfig/dependencies/pre" = {
    if (exists("/software/components/metaconfig")) {
        append("metaconfig");
    } else {
        SELF;
    };
};

prefix '/software/components/altlogrotate/entries/httpd';

"create" = true;
"createparams/group" = "root";
"createparams/owner" = "root";
"createparams/mode" = "0644";
"frequency" = "weekly";
"pattern" = "/var/log/httpd/*log";
"compress" = true;
"delaycompress" = true;
"scripts/postrotate" = "service httpd reload &>/dev/null || true";
"missingok" = true;
"sharedscripts" = true;
include 'common/httpd/logstash';
include if (IS_PUBLIC_HTTPD) {
    'common/httpd/downloadcerts';
};

# default config
include 'common/httpd/config/default';
