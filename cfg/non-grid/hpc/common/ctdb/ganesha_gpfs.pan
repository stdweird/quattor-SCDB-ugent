unique template common/ctdb/ganesha_gpfs;

# set the CTDB GANRECDOR manually to control its location

variable CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR ?= undef;

variable CTDB_GANESHA_GPFS_GANRECDIR_TARGET = format("%s/ganesharecdir", CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR);

include { 'components/dirperm/config'};
"/software/components/dirperm/paths" = {
    append(nlist(
               "path", CTDB_GANESHA_GPFS_GANRECDIR_TARGET,
               "owner", "root:root",
               "perm", "0750",
               "type", "d",
               ));
    append(nlist(
               "path", CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR,
               "owner", "root:root",
               "perm", "0755",
               "type", "d",
               ));
    append(nlist(
               "path", "/user",
               "owner", "root:root",
               "perm", "0755",
               "type", "d",
               ));
};

# this is normally set through ctdb/events.d/60.ganesha, but offers no control
include { 'components/symlink/config' };
"/software/components/symlink/links" = append(nlist(
    "name", "/var/lib/nfs/ganesha",
    "target", CTDB_GANESHA_GPFS_GANRECDIR_TARGET,
    "replace", nlist("all","yes"),
    ));
