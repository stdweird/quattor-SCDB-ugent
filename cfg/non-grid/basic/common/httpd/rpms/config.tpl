unique template common/httpd/rpms/config;

variable PKG_ARCH_HTTPD ?= PKG_ARCH_DEFAULT;

variable HTTPD_VERSION ?= "2.2.3-43.sl5.3";

"/software/packages"=pkg_repl("httpd",HTTPD_VERSION,PKG_ARCH_HTTPD);

"/software/packages"=pkg_repl("perl-Apache-Admin-Config","0.94-1.el5.rf","noarch");
