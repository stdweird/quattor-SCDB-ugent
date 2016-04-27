unique template common/environment-modules/packages;

variable ENVIRONMENT_MODULES_VERSION ?= format('3.2.10-3.ug%s', RPM_BASE_FLAVOUR_DIST);
"/software/packages" = pkg_repl("environment-modules", ENVIRONMENT_MODULES_VERSION, PKG_ARCH_DEFAULT);

prefix "/software/packages";
"{tk}" = dict();
"{tk-devel}" = dict();
"{tcl}" = dict();
"{tcl-devel}" = dict();

# only required for Lmod
"{lua-filesystem}" = dict();
"{lua-posix}" = dict();
# these are optional for Lmod
"{lua-json}" = dict();
"{lua-term}" = dict();
