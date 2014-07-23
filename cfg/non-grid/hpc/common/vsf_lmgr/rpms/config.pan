unique template common/vsf_lmgr/rpms/config;

variable PKG_ARCH_FLEXLM ?= PKG_ARCH_DEFAULT;

variable VSF_LMGR_VERSION ?= '5.5.155.27-1.ug';

'/software/packages' = pkg_repl("vsf_lmgr",VSF_LMGR_VERSION,PKG_ARCH_FLEXLM);


