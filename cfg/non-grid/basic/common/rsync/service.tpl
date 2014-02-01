unique template common/rsync/service;

#same version with rfx packages
include { "common/rsync/rpms/config" };

include { 'common/rsync/config' };

# Start rsyncd
include { 'components/chkconfig/config' };
# rsyncd is now a service in xinetd
"/software/components/chkconfig/service/rsync" = nlist("on", "");

## add rsyncd user

include { 'components/accounts/config' };

"/software/components/accounts/groups/rsyncd" =
  nlist("gid",150);

"/software/components/accounts/users/rsyncd" = nlist(
  "uid", 150,
  "groups", list("rsyncd"),
  "comment","Rsync Daemon",
  "shell", "/sbin/nologin",
  "homeDir", "/"
);
