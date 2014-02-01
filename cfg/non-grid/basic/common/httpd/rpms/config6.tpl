unique template common/httpd/rpms/config6;

variable PKG_ARCH_HTTPD ?= PKG_ARCH_DEFAULT;

variable HTTPD_VERSION ?= "2.2.15-15.sl6.1";

"/software/packages"=pkg_repl("httpd",HTTPD_VERSION,PKG_ARCH_HTTPD);
"/software/packages"=pkg_repl("mod_ssl",HTTPD_VERSION,PKG_ARCH_HTTPD);

"/software/packages"=pkg_repl("perl-Apache-Admin-Config","0.94-1.el6.rf","noarch");
