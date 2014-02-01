unique template node/wn/rpms/extras;

variable PKG_ARCH_EXTRAS ?= PKG_ARCH_DEFAULT;

'/software/packages' = pkg_repl('chrpath',"0.13-1.el5.rf",PKG_ARCH_EXTRAS);
'/software/packages' = pkg_repl('sdparm',"1.06-1.el5.rf",PKG_ARCH_EXTRAS);