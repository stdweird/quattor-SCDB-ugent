unique template common/ganesha/packages;

"/software/packages" = pkg_repl("nfs-ganesha-common", GANESHA_VERSION ,"x86_64");
# fsal sepcific is included in fsal section

# missing dependencies
prefix "/software/packages";
"{gperftools-libs}" = nlist();
"{net-snmp-libs}" = nlist();