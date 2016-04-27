unique template common/postfix/rpms/config6;

variable PKG_ARCH_POSTFIX ?= PKG_ARCH_DEFAULT;

variable POSTFIX_VERSION ?= "2.6.6-2.2.el6_1";

'/software/packages' = pkg_repl("postfix",POSTFIX_VERSION,PKG_ARCH_POSTFIX);
