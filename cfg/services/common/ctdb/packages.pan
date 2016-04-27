unique template common/ctdb/packages;

variable CTDB_VERSION ?= '2.5.4-2.el6.ug.withlink';

"/software/packages" = pkg_repl('ctdb*',CTDB_VERSION, PKG_ARCH_DEFAULT);

prefix "/software/packages";
# only for ctdb2.X
"{tdb-tools}" = dict();
"{libtdb}" = dict();
"{libtevent}" = dict();
"{quota}" = dict(); # rpc.rquotad checks
include 'components/dirperm/config';
# Hard coded socket lock directory not created by default
"/software/components/dirperm/paths" = append(dict(
    "path",    '/var/lib/run/ctdb',
    "owner",   "root:root",
    "perm",    "0755",
    "type",    "d",
));
