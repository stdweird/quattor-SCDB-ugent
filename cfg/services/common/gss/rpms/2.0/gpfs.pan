unique template common/gss/rpms/2.0/gpfs;

variable OS_REPOSITORY_LIST = append("gss/gpfs");

final variable PKG_ARCH_GPFS = 'x86_64';
variable GPFS_VERSION_BASE = '4.1.0';

final variable GPFS_VERSION = format('%s-7', GPFS_VERSION_BASE);
final variable GPFS_GNR_VERSION = format('%s-7', GPFS_VERSION_BASE);
final variable GPFS_GSS_VERSION = format('%s-3', GPFS_VERSION_BASE);

final variable GPFS_KERNEL_VERSION = format("%s.%s", KERNEL_VERSION, PKG_ARCH_GPFS);
final variable GPFS_LANG_LOCAL = 'en_US';

variable GPFS_BASE_UPDATE_RELEASE ?= '';

'/software/packages' = pkg_repl("gpfs.base",GPFS_VERSION+GPFS_BASE_UPDATE_RELEASE, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.docs", GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl("gpfs.gpl", GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl(format("gpfs.msg.%s", GPFS_LANG_LOCAL), GPFS_VERSION, "noarch");
'/software/packages' = pkg_repl(format("gpfs.gplbin-%s", GPFS_KERNEL_VERSION), GPFS_VERSION, PKG_ARCH_GPFS);

'/software/packages' = pkg_repl("gpfs.ext", GPFS_VERSION, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gskit", "8.0.*", PKG_ARCH_GPFS);

# gnr/gss
'/software/packages' = pkg_repl("gpfs.gnr", GPFS_GNR_VERSION, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gnr.base","1.0.0-0", PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.platform", format("%s-0", GPFS_VERSION_BASE), PKG_ARCH_GPFS);

'/software/packages' = pkg_repl("gpfs.gss.firmware", GPFS_GSS_VERSION, PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gss.gui", format("%s.1", GPFS_GSS_VERSION), PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gss.pmcollector", format("%s.el6", GPFS_GSS_VERSION), PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gss.pmsensors", format("%s.el6", GPFS_GSS_VERSION), PKG_ARCH_GPFS);

# for mmauth/AUTHONLY
prefix '/software/packages';
'{openssl-devel}' = dict();
'{ksh}' = dict();
'{m4}' = dict(); # needed for policy parsing
'{sg3_utils}' = dict(); # for GUI mmdiscovercomp
