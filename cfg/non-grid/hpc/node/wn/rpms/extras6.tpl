unique template node/wn/rpms/extras6;

variable PKG_ARCH_EXTRAS ?= PKG_ARCH_DEFAULT;

'/software/packages' = pkg_repl('chrpath',"0.13-7."+RPM_BASE_FLAVOUR_NAME,PKG_ARCH_EXTRAS);
'/software/packages' = pkg_repl('sdparm',"1.04-1.1."+RPM_BASE_FLAVOUR_NAME,PKG_ARCH_EXTRAS);