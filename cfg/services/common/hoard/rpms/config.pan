unique template common/hoard/rpms/config;

prefix "/software/packages";

"{hoard}" = dict();
"{hoard-devel}" = dict();

# Also install jemalloc everywhere hoard is required
"{jemalloc}" = dict();
