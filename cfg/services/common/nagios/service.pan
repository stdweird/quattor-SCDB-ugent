unique template common/nagios/service;
include 'common/nagios/config';
## add nagios user
include 'components/accounts/config';
"/software/components/accounts/groups/nagios" =
  dict("gid", 110);

"/software/components/accounts/users/nagios" = dict(
  "uid", 110,
  "groups", list("nagios"),
  "comment","nagios",
  "shell", "/bin/sh",
  "homeDir", "/var/log/nagios"
);

prefix "/software/components/dirperm";
"paths" = append(dict(
    "path", "/var/log/nagios",
    "owner", "nagios:nagios",
    "perm", "0755",
    "type", "d",
    ));
