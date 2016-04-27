unique template common/icinga-web/packages;

"/software/packages" = pkg_repl('icinga-web', ICINGAWEB_VERSION, 'noarch');

prefix "/software/packages";
"{php-soap}" = dict();
"{php-xmlrpc}" = dict();
