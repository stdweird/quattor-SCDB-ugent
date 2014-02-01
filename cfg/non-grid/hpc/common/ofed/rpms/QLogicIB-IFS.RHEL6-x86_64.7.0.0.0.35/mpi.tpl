unique template common/ofed/rpms/QLogicIB-IFS.RHEL6-x86_64.7.0.0.0.35/mpi;

variable PKG_ARCH_DEFAULT ?= PKG_ARCH_DEFAULT;

'/software/packages' = pkg_repl("mpi-benchmark","3.0-610.1020_rhel5_qlc",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mpi-devel","3.0-610.1020_rhel5_qlc","noarch");
'/software/packages' = pkg_repl("mpi-doc","3.0-610.1020_rhel5_qlc","noarch");
'/software/packages' = pkg_repl("mpi-frontend","3.0-610.1020_rhel5_qlc","i386");
'/software/packages' = pkg_repl("mpi-libs","3.0-610.1020_rhel5_qlc",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mpi-selector","1.0.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich2_gcc_qlc","1.6-2",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich2_intel_qlc","1.6-2",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich2_pgi_qlc","1.6-2",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich_gcc_qlc","1.2.0-3635",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich_intel_qlc","1.2.0-3635",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich_pgi_qlc","1.2.0-3635",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("openmpi_gcc_qlc","1.4.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("openmpi_intel_qlc","1.4.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("openmpi_pgi_qlc","1.4.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("qlogic-mpi-register","0.1.0-610.1020_rhel5_qlc","noarch");
