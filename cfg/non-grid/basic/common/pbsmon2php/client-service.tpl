unique template common/pbsmon2php/client-service;

"/software/packages/{pbsmon2php-client-ugent}" = nlist();

"/software/components/dirperm/paths" = push(nlist(
             "path",    "/var/run/pbsmon2php",
             "owner",   "root:root",
             "perm",    "0755",
             "type",    "d"
            ));


include 'components/cron/config';

"/software/components/cron/entries" = append(
    nlist("command", ". /etc/profile.d/vsc.sh; /usr/bin/pbsmon_json.py",
	  "name", "pbsmon-client",
	  "comment", "PBSmon JSON file generation",
	  "user", "root",
	  "group", "root",
	  "timing", nlist("minute", "*/5")));
