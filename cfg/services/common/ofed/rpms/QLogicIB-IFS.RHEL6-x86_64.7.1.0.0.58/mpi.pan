unique template common/ofed/rpms/QLogicIB-IFS.RHEL6-x86_64.7.1.0.0.58/mpi;

variable PKG_ARCH_DEFAULT ?= PKG_ARCH_DEFAULT;

'/software/packages' = pkg_repl("mpi-selector","1.0.3-1",PKG_ARCH_DEFAULT);
