unique template common/nagios/service;

include { 'common/nagios/config' };

## add nagios user

include { 'components/accounts/config' };

"/software/components/accounts/groups/nagios" =
  nlist("gid", 110);

"/software/components/accounts/users/nagios" = nlist(
  "uid", 110,
  "groups", list("nagios"),
  "comment","nagios",
  "shell", "/bin/sh",
  "homeDir", "/var/log/nagios"
);

prefix "/software/components/dirperm";
"paths" = append(nlist(
             "path",    "/var/log/nagios",
             "owner",   "nagios:nagios",
             "perm",    "0755",
             "type",    "d"
            ));
# add directory for any chache files for nagios checks
"paths" = append(nlist(
               "path", "/var/cache/icinga",
               "owner", "nagios:nagios",
               "perm", "0750",
               "type", "d"));
            