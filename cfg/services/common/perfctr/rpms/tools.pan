unique template common/perfctr/rpms/tools;

prefix '/software/packages';

"{papi}" = dict();
"{papi-devel}" = dict();
"{perfsuite}" = {
    if (RPM_BASE_FLAVOUR_VERSIONID == 5) {
        null;
    } else {
        dict();
    };
};
"{tdom}" = dict();
