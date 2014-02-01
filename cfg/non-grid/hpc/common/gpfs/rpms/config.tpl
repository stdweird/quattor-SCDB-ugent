unique template common/gpfs/rpms/config;

include { 'rpms/gpfs' };

variable GPFS_REPOSITORY ?= "site/add_gpfs_repo";
include {GPFS_REPOSITORY};

## base rpms
include { 'common/gpfs/rpms/base' };

variable GPFS_BASE_UPDATE_RELEASE ?= '';

'/software/packages' = pkg_repl("gpfs.base",GPFS_VERSION+GPFS_BASE_UPDATE_RELEASE,PKG_ARCH_GPFS);
#'/software/packages' = pkg_repl("gpfs.gui",GPFS_VERSION,PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.docs",GPFS_VERSION,"noarch");
'/software/packages' = pkg_repl("gpfs.gpl",GPFS_VERSION,"noarch");
'/software/packages' = pkg_repl("gpfs.msg."+GPFS_LANG_LOCAL,GPFS_VERSION,"noarch");

#'/software/packages' = pkg_repl("gpfs.gplbin-"+GPFS_KERNEL_VERSION_FIXED,GPFS_VERSION,PKG_ARCH_GPFS);
'/software/packages' = pkg_repl("gpfs.gplbin-"+GPFS_KERNEL_VERSION,GPFS_VERSION,PKG_ARCH_GPFS);

# for mmauth/AUTHONLY
prefix '/software/packages';
'{openssl-devel}' = nlist();
'{ksh}' = nlist();
'{m4}' = nlist(); # needed for policy parsing

# local script
'{waitforgpfs}' = nlist();