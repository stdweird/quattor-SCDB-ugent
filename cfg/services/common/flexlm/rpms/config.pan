unique template common/flexlm/rpms/config;

variable PKG_ARCH_FLEXLM ?= PKG_ARCH_DEFAULT;

variable FLEXLM_VERSION ?= '11.11.0-intel.ug.1.'+RPM_BASE_FLAVOUR_NAME;

'/software/packages' = pkg_repl("flexlm-server",FLEXLM_VERSION,PKG_ARCH_FLEXLM);

# has dependency on redhat-lsb
prefix "/software/packages";
"{redhat-lsb}" = dict();
