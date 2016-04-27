unique template common/ganesha/packages;

"/software/packages" = {
    if (GANESHA_VERSION_2) {
        pkg_repl("nfs-ganesha", GANESHA_VERSION ,"x86_64");
        pkg_repl("nfs-ganesha-utils", GANESHA_VERSION ,"x86_64");
        SELF["pygobject2"] = dict();
    } else {
        pkg_repl("nfs-ganesha-common", GANESHA_VERSION ,"x86_64");
    };
    SELF;
};

# fsal specific is included in fsal section

# missing dependencies
prefix "/software/packages";
"{gperftools-libs}" = dict();
"{net-snmp-libs}" = dict();
