unique template common/moab/server/rpms/official;

'/software/packages'= {
    versions = matches(MOAB_RPM_VERSION, '^(\d+)\.(\d+)\.');
    main_version = to_long(versions[1]);
    
    name="workload-manager";
    if(main_version == 7 ) {
        name=format("hpc-%s-libtorque", name);

        # only for 7
        SELF[escape(format("moab-%s-client", name))] = dict();
    };
    
    pkg_repl(format("moab-%s*", name), MOAB_RPM_VERSION, "x86_64");
    SELF[escape(format("moab-%s-common", name))] = dict();
    
    SELF;
};
