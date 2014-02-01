unique template common/cluster-status/rpms/config6;

variable CLUSTERSTATUS_VERSION ?= "0.1-2";
variable PKG_ARCH_CLUSTERSTATUS ?= PKG_ARCH_DEFAULT;

"/software/packages" = pkg_repl("cluster-status-ugent", CLUSTERSTATUS_VERSION, PKG_ARCH_CLUSTERSTATUS);
