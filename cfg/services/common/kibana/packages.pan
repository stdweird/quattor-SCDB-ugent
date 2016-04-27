unique template common/kibana/packages;

"/software/packages" = {
    pkg_repl("kibana", format("%s.*", KIBANA_VERSION), PKG_ARCH_DEFAULT);
    SELF;
};
