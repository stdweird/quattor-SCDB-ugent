unique template common/shorewall/rpms/config;

prefix "/software/packages";

"{shorewall}" = dict();
"{shorewall-init}" = { if (RPM_BASE_FLAVOUR_VERSIONID == 5) { null;} else {dict();};};
