unique template common/nscd/service;
include 'common/nscd/config';
# Start nscd
include 'components/chkconfig/config';
"/software/components/chkconfig/service/nscd/on" = "";
"/software/components/chkconfig/service/nscd/startstop" = true;

## add nscd user
include 'components/accounts/config';
"/software/components/accounts/groups/nscd" =
  dict("gid", 28);

"/software/components/accounts/users/nscd" = dict(
  "uid", 28,
  "groups", list("nscd"),
  "comment","NSCD Daemon",
  "shell", "/sbin/nologin",
  "homeDir", "/"
);
