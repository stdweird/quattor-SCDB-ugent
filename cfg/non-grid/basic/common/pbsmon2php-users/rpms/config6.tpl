unique template common/pbsmon2php-users/rpms/config6;

variable PBSMON2PHPUSERS_VERSION ?= "0.2-2";
variable PKG_ARCH_PBSMON2PHPUSERS ?= PKG_ARCH_DEFAULT;

"/software/packages" = pkg_repl("pbsmon2php-users-ugent", PBSMON2PHPUSERS_VERSION, PKG_ARCH_PBSMON2PHPUSERS);
