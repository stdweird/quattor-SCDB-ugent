unique template common/ganesha/fsal/gpfs;

variable GANESHA_GPFS_MULTIPLIER ?= 4;

"/software/packages" = { 
    pkg_repl("nfs-ganesha-gpfs", GANESHA_VERSION ,"x86_64");
};

include { format('common/ganesha/fsal/gpfs_%s', METACONFIG_GANESHA_VERSION) };
