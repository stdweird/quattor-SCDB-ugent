unique template common/yum-mirror/service;

include 'common/yum-mirror/config';

include 'common/yum-mirror/nfs';

include 'components/cron/config';

include 'common/yum-mirror/rpms';

"/system/monitoring/hostgroups" = append("yum-mirror");

"/software/components/cron/entries" = {
    append(
        dict("command", "/usr/bin/reposnap.sh",
            "name", "reposnap",
            "comment", "Yum repository mirroring and snapshotting",
            "user", "reposnap",
            "group", "reposnap",
            "timing", dict("hour", "4", "minute", "35", "weekday", "0")));
    append(
        dict("command", '/usr/bin/pkgsnap.sh',
            "name", "pkgsnap",
            "comment", "Create sym links to snapshots",
            "user", "reposnap",
            "group", "reposnap",
            "timing", dict("hour", "1", "minute", "23",
                              "weekday", "3")));
    append(
        dict("command", "find /var/www/packages/* -maxdepth 1 -type l -not -xtype d -delete",
            "name", "snap-purge",
            "comment", "Purge old snapshots",
            "user", "reposnap",
            "group", "reposnap",
            "timing", dict("hour", "6", "minute", "32",
                              "day", "3")));
    append(
        dict("command", "find /var/tmp/* -name 'createrepo*' -mtime +10 -delete",
            "name", "tmp_cleanup",
            "comment", "clean up old files from createrepo",
            "timing", dict("hour", "1", "minute", "32")));
    append(
        dict("command", "/usr/lib64/nagios/plugins/hpc/check_rpm_repo.py",
            "name", "check_rpm_repo",
            "comment", "Check if reposnap mirrors are available",
            "timing", dict("hour", "7", "minute", "0")));
    append(
        dict("command", "find /var/www/packages/public/ -user root -not -path '*.snapshot*' -exec chown reposnap:apache '{}' \\ ;",
            "name", "repodata_ownership",
            "comment", "Make sure all files are owned by repodata instead of root",
            "user", "root",
            "group", "root",
            "timing", dict("hour", "7", "minute", "35")));
};

include 'components/accounts/config';

"/software/components/accounts/groups/reposnap/gid" = 1203;

prefix "/software/components/accounts/users/reposnap";

"uid" = 1203;
"shell" = "/bin/bash";
"password" = "!";
"comment" = "Account for snapshotting Yum repositories";
"groups/0" = "reposnap";
"createHome" = false;
"homeDir" = "/var/www/packages";

include 'components/dirperm/config';

"/software/components/dirperm/paths" = append(
    dict("path", "/var/www/packages",
        "owner", "reposnap:apache",
        "type", "d",
        "perm", "0755"));

"/software/components/useraccess/users/reposnap/roles" = UGENT_ACTIVE_ADMINS;

include 'common/yum-mirror/httpd';
