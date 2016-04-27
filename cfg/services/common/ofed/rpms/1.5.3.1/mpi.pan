unique template common/ofed/rpms/1.5.3.1/mpi;

variable PKG_ARCH_DEFAULT ?= PKG_ARCH_DEFAULT;

variable PKG_KERNEL_OFED ?= "2.6.18_238.9.1.el5.perfctr.2.6.42.ug.1";

'/software/packages' = pkg_repl("mpi-selector","1.0.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mpitests_openmpi_gcc","3.2-923",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mpitests_mvapich_gcc","3.2-923",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mpitests_mvapich2_gcc","3.2-923",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("openmpi_gcc","1.4.3-1",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich_gcc","1.2.0-3635",PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl("mvapich2_gcc","1.6-2",PKG_ARCH_DEFAULT);
