unique template common/hwloc/packages;

## updated version of hwloc needed

prefix  '/software/packages';

"{hwloc}" = nlist();
"{hwloc-devel}" = nlist();
"{pciutils}" = nlist();
"{pciutils-devel}" = nlist();
"{pciutils-libs}" = { if (RPM_BASE_FLAVOUR_VERSIONID == 5) { null;} else {nlist();};};
