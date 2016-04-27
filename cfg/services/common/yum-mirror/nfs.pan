unique template common/yum-mirror/nfs;
include 'components/nfs/config';
variable MIRROR_NFS_VOLUME ?= error ("NFS volume must be declared by now");

"/software/components/nfs/mounts" = {
    append(dict("device", MIRROR_NFS_VOLUME,
	    "mountpoint", "/var/www/packages",
	    "fstype", "nfs",
	    "options", "rw,noatime,soft,intr,tcp,rsize=32768,wsize=32768"));
};

"/software/components/chkconfig/dependencies/pre" = append("nfs");
