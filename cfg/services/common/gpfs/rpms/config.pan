unique template common/gpfs/rpms/config;

include 'rpms/gpfs';

variable GPFS_REPOSITORY ?= "site/add_gpfs_repo";
include GPFS_REPOSITORY;
## base rpms
include 'common/gpfs/rpms/base';

variable GPFS_BASE_UPDATE_RELEASE ?= '';

'/software/packages' = {
    pkg_repl("gpfs.base", GPFS_VERSION+GPFS_BASE_UPDATE_RELEASE, PKG_ARCH_GPFS);
    pkg_repl("gpfs.docs", GPFS_VERSION, "noarch");
    pkg_repl("gpfs.gpl", GPFS_VERSION, "noarch");
    pkg_repl("gpfs.msg."+GPFS_LANG_LOCAL, GPFS_VERSION, "noarch");

    pkg_repl("gpfs.gplbin-"+GPFS_KERNEL_VERSION, GPFS_VERSION, PKG_ARCH_GPFS);

    if (GPFS_VERSION_MAJOR >= 4) {
        pkg_repl("gpfs.ext", GPFS_VERSION+GPFS_BASE_UPDATE_RELEASE, PKG_ARCH_GPFS);
        pkg_repl("gpfs.gskit", format("%s-*", GPFS_GSKIT_VERSION), PKG_ARCH_GPFS);
    };

    if (GPFS_HADOOP_CONNECTOR && (GPFS_VERSION_MAJOR >= 4) && (GPFS_VERSION_MINOR >= 1) && (GPFS_VERSION_SUBMINOR >= 1)) {
        pkg_repl("gpfs.hadoop-connector", GPFS_HADOOP_CONNECTOR_VERSION, PKG_ARCH_GPFS);
    };
    
    SELF;
};    

# for mmauth/AUTHONLY
prefix '/software/packages';
'{openssl-devel}' = dict();
'{ksh}' = dict();
'{m4}' = dict(); # needed for policy parsing

# local script
'{waitforgpfs}' = dict();
