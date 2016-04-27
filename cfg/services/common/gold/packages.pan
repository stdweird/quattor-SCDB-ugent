unique template common/gold/packages;

'/software/packages' = {
    pkg_repl("gold","2.1.12.1-1.nodeps",PKG_ARCH_DEFAULT);
    SELF[escape("rrdtool")] = dict();
    SELF[escape("rrdtool-perl")] = dict();
    SELF;
};
