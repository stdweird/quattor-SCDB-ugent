unique template common/cpuset/rpms/config;

variable PKG_ARCH_CPUSET ?= PKG_ARCH_DEFAULT;

prefix '/software/packages';
"{libcpuset}"=nlist();
"{libbitmask}"=nlist();

# the init.d / profile.d files
"{vsc-cpuset-ugent}" = nlist();