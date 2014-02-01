unique template common/slocate/config;

## FC14 defaults
variable SLOCATE_PRUNEFS ?= list(
    "9p", "afs", "anon_inodefs", "auto", "autofs", "bdev", "binfmt_misc", 
    "cgroup", "cifs", "coda", "configfs", "cpuset", "debugfs", "devpts", 
    "ecryptfs", "exofs", "fuse", "fusectl", "gfs", "gfs2", "hugetlbfs", 
    "inotifyfs", "iso9660", "jffs2", "lustre", "gpfs", "mqueue", "ncpfs", "nfs", 
    "nfs4", "nfsd", "pipefs", "proc", "ramfs", "rootfs", "rpc_pipefs", 
    "securityfs", "selinuxfs", "sfs", "sockfs", "sysfs", "tmpfs", "ubifs", 
    "udf", "usbfs");
variable SLOCATE_PRUNEPATHS ?= list(
    "/afs","/media","/net","/sfs", "/udev", 
    "/var/cache/ccache", "/var/spool/cups","/var/spool/squid",
    "/tmp","/var/tmp"
);
variable SLOCATE_PRUNEPATHS_SITE ?= list();

variable SLOCATE_PRUNE_BIND_MOUNTS ?= "yes";

variable SLOCATE_PRUNENAMES ?= list(".git",".hg",".svn");

variable CONTENT = {
    txt='';
    txt=txt+'#PRUNE_BIND_MOUNTS = "'+SLOCATE_PRUNE_BIND_MOUNTS+'"'+"\n";

    txt=txt+'PRUNEFS = "';
    foreach(i;v;SLOCATE_PRUNEFS){
        txt = txt+v+" ";
    };
    txt=txt+'"'+"\n";

    txt=txt+'PRUNEPATHS = "';
    foreach(i;v;SLOCATE_PRUNEPATHS){
        txt = txt+v+" ";
    };
    foreach(i;v;SLOCATE_PRUNEPATHS_SITE){
        txt = txt+v+" ";
    };
    txt=txt+'"'+"\n";

    txt=txt+'#PRUNENAMES = "';
    foreach(i;v;SLOCATE_PRUNENAMES){
        txt = txt+v+" ";
    };
    txt=txt+'"'+"\n";

    txt;
};
'/software/components/filecopy/services' =
  npush(escape("/etc/updatedb.conf"),
        nlist('config',CONTENT,
              'owner','root:root',
              'perms', '0755'));
