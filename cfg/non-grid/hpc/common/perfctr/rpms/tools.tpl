unique template common/perfctr/rpms/tools;

prefix '/software/packages';

"{papi}" = nlist();
"{papi-devel}" = nlist();
"{perfsuite}" = {
    if (RPM_BASE_FLAVOUR_VERSIONID == 5) {
        null;
    } else {
        nlist();
    };
};
"{tdom}" = nlist();
