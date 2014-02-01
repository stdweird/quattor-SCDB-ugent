unique template common/yum-mirror/service;

include 'common/yum-mirror/config';

include 'common/yum-mirror/nfs';

include 'components/cron/config';

include 'common/yum-mirror/rpms';

"/software/components/cron/entries" = {
    append(
        nlist("command", "/usr/bin/reposnap.sh",
	  "name", "reposnap",
	  "comment", "Yum repository mirroring and snapshotting",
	  "user", "reposnap",
	  "group", "reposnap",
	  "timing", nlist("hour", "4", "minute", "35", "weekday", "0")));
    append(
        nlist("command", '/usr/bin/pkgsnap.sh',
              "name", "pkgsnap",
              "comment", "Create sym links to snapshots",
              "user", "reposnap",
              "group", "reposnap",
              "timing", nlist("hour", "1", "minute", "23",
                              "weekday", "3")));
    append(
        nlist("command", "find /var/www/packages/* -maxdepth 1 -type l -not -xtype d -delete",
              "name", "snap-purge",
              "comment", "Purge old snapshots",
              "user", "reposnap",
              "group", "reposnap",
              "timing", nlist("hour", "6", "minute", "32",
                              "day", "3")));
};


include 'components/accounts/config';

"/software/components/accounts/groups/reposnap/gid" = 1203;

prefix "/software/components/accounts/users/reposnap";

"uid" = 1203;
"shell" = "/sbin/nologin";
"password" = "!";
"comment" = "Account for snapshotting Yum repositories";
"groups/0" = "reposnap";
"createHome" = false;
"homeDir" = "/var/www/packages";

include 'components/dirperm/config';

"/software/components/dirperm/paths" = append(
    nlist("path", "/var/www/packages",
	  "owner", "reposnap:apache",
	  "type", "d",
	  "perm", "0755"));

include 'common/yum-mirror/httpd';
