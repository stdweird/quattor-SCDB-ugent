unique template common/pbsmon2php/client-service;

"/software/packages/{pbsmon2php-client-ugent}" = dict();

"/software/components/dirperm/paths" = push(dict(
             "path",    "/var/run/pbsmon2php",
             "owner",   "root:root",
             "perm",    "0755",
             "type",    "d"
            ));


include 'components/cron/config';

"/software/components/cron/entries" = append(
    dict("command", ". /etc/profile.d/vsc.sh; /usr/bin/pbsmon_json.py",
	  "name", "pbsmon-client",
	  "comment", "PBSmon JSON file generation",
	  "user", "root",
	  "group", "root",
	  "timing", dict("minute", "*/5")));
