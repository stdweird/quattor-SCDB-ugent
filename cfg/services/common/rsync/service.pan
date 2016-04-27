unique template common/rsync/service;

# same version with rfx packages
include "common/rsync/rpms/config";

include 'common/rsync/config';

# Start rsyncd
# rsyncd is a service in xinetd on el6
"/software/components/chkconfig/service" = {
    if (RPM_BASE_FLAVOUR_VERSIONID >= 7) {
        SELF["rsyncd"] = dict("on", "", "startstop", true);
    };
    SELF;
};

# add rsyncd user
"/software/components/accounts/groups/rsyncd" =
  dict("gid",150);

"/software/components/accounts/users/rsyncd" = dict(
    "uid", 150,
    "groups", list("rsyncd"),
    "comment","Rsync Daemon",
    "shell", "/sbin/nologin",
    "homeDir", "/"
);
