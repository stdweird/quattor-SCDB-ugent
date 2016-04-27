unique template common/ctdb/ganesha_gpfs;

# set the CTDB GANRECDOR manually to control its location
include 'components/dirperm/config';
"/software/components/dirperm/paths" = {
    append(dict(
               "path", CTDB_GANESHA_GPFS_GANRECDIR_TARGET,
               "owner", "root:root",
               "perm", "0750",
               "type", "d",
               ));
    append(dict(
               "path", CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR,
               "owner", "root:root",
               "perm", "0755",
               "type", "d",
               ));
    append(dict(
               "path", "/user",
               "owner", "root:root",
               "perm", "0755",
               "type", "d",
               ));
};

# this is normally set through ctdb/events.d/60.ganesha, but offers no control
include 'components/symlink/config';
"/software/components/symlink/links" = append(dict(
    "name", "/var/lib/nfs/ganesha",
    "target", CTDB_GANESHA_GPFS_GANRECDIR_TARGET,
    "replace", dict("all","yes"),
    ));
