unique template common/environment-modules/packages;

# fixed version for syslog wrapper build
variable EM_DIST = {
    if(RPM_BASE_FLAVOUR_VERSIONID == 5) {
        '';
    } else {
        format('.%s',RPM_BASE_FLAVOUR_NAME);
    };
};
variable ENVIRONMENT_MODULES_VERSION ?= format('3.2.10-1.ug%s', EM_DIST);
"/software/packages" = pkg_repl("environment-modules", ENVIRONMENT_MODULES_VERSION, PKG_ARCH_DEFAULT);

prefix "/software/packages";
"{tk}" = nlist();
"{tk-devel}" = nlist();
"{tcl}" = nlist();
"{tcl-devel}" = nlist();



