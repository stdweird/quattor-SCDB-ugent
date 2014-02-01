unique template common/gss/rpms/gpfs;

variable OS_REPOSITORY_LIST = append("gss/gpfs");

final variable PKG_ARCH_GPFS = 'x86_64';
final variable GPFS_VERSION_BASE = '3.5.0';
final variable GPFS_VERSION = format('%s-11', GPFS_VERSION_BASE);
final variable GPFS_KERNEL_VERSION = format("%s.%s", KERNEL_VERSION, PKG_ARCH_GPFS);
final variable GPFS_LANG_LOCAL = 'en_US';

'/software/packages' = pkg_repl("gpfs.base", GPFS_VERSION, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.docs", GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl("gpfs.gpl", GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl(format("gpfs.msg.%s", GPFS_LANG_LOCAL), GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl(format("gpfs.gplbin-%s", GPFS_KERNEL_VERSION), GPFS_VERSION, PKG_ARCH_GPFS);

# gnr/gss
'/software/packages' = pkg_repl("gpfs.gnr", GPFS_VERSION, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.platform", format("%s-0", GPFS_VERSION_BASE), PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gnr.base","1.0.0-0", PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gss.firmware",format("%s-1", GPFS_VERSION_BASE), PKG_ARCH_GPFS);     

# for mmauth/AUTHONLY
prefix '/software/packages';
'{openssl-devel}' = nlist();
'{ksh}' = nlist();
'{m4}' = nlist(); # needed for policy parsing

