unique template common/fstab/service;

# not really a service template; 
# just a wrapper around components/fstab/config
# to help protect filesystems

include 'components/fstab/config';

variable FSTAB_PROTECTED_EXTRA_MOUNTS ?= list();
variable FSTAB_PROTECTED_EXTRA_FSTYPES ?= list();

prefix '/software/components/fstab';
variable FSTAB_PROTECTED_MOUNTS = {
    # these should be the schema defaults
    # always append them
    t = list(
        "/", "/usr", "/home", "/opt", "/var", "/var/lib", "/var/lib/rpm",
        "/usr/bin", "/usr/sbin", "/usr/lib", "/usr/local/bin", "/usr/lib64",
        "/bin", "/sbin", "/etc", "swap", "/proc", "/sys", "/dev/pts", "/dev/shm",
        "/media/floppy", "/mnt/floppy", "/media/cdrecorder", "/media/cdrom",
        "/mnt/cdrom", "/boot",
        );
    foreach (idx;mntpt;FSTAB_PROTECTED_EXTRA_MOUNTS) {
        append(t, mntpt);
    };
    t;
};

variable FSTAB_PROTECTED_FSTYPES = {
    t = list('gpfs');
    foreach (idx;fst;FSTAB_PROTECTED_EXTRA_FSTYPES) {
        append(t, fst);
    };
    t;
};

'keep/mounts' = FSTAB_PROTECTED_MOUNTS;
'static/mounts'= FSTAB_PROTECTED_MOUNTS;
'keep/fs_types' = FSTAB_PROTECTED_FSTYPES;
'static/fs_types' = FSTAB_PROTECTED_FSTYPES;
