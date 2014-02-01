unique template common/torque2/packages;

include {
    if (match(TORQUE_RPM_VERSION,'^[4-9]\.')) {
        'common/hwloc/packages';
    };
};

'/software/packages'=pkg_repl('torque*', TORQUE_RPM_VERSION, 'x86_64');
prefix '/software/packages';
"{torque-devel}" = nlist();
"{libxml2-devel}" = nlist();
"{openssl-devel}" = nlist();

variable TORQUE_X_FORWARDING ?= false;

include {
    if (TORQUE_X_FORWARDING) {
         'site/rpms/xforwarding';
    };
};
