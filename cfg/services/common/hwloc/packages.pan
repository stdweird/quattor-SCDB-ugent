unique template common/hwloc/packages;

## updated version of hwloc needed

prefix  '/software/packages';

"{hwloc}" = dict();
"{hwloc-devel}" = dict();
"{pciutils}" = dict();
"{pciutils-devel}" = dict();
"{pciutils-libs}" = { if (RPM_BASE_FLAVOUR_VERSIONID == 5) { null;} else {dict();};};
