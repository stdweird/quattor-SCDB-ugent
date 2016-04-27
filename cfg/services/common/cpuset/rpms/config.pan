unique template common/cpuset/rpms/config;

variable PKG_ARCH_CPUSET ?= PKG_ARCH_DEFAULT;

prefix '/software/packages';
"{libcpuset}"=dict();
"{libbitmask}"=dict();

# the init.d / profile.d files
"{vsc-cpuset-ugent}" = dict();
