unique template common/moab/server/rpms/official;

'/software/packages'= {
    pkg_repl("moab-hpc-workload-manager-libtorque*", MOAB_RPM_VERSION, "x86_64");
    SELF;
};

prefix '/software/packages';
"{moab-hpc-workload-manager-libtorque-common}"=nlist();
"{moab-hpc-workload-manager-libtorque-client}"=nlist();
