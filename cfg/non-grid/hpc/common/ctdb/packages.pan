unique template common/ctdb/packages;

variable CTDB_VERSION ?= '2.2-1';

"/software/packages" = pkg_repl('ctdb*',CTDB_VERSION, PKG_ARCH_DEFAULT);

prefix "/software/packages";
# only for ctdb2.X
"{tdb-tools}" = nlist();
"{libtdb}" = nlist();
"{libtevent}" = nlist();
"{quota}" = nlist(); # rpc.rquotad checks