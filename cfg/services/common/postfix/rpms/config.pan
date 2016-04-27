unique template common/postfix/rpms/config;

variable PKG_ARCH_POSTFIX ?= PKG_ARCH_DEFAULT;

variable POSTFIX_VERSION ?= "2.3.3-2.1.el5_2";

'/software/packages' = pkg_repl("postfix",POSTFIX_VERSION,PKG_ARCH_POSTFIX);
