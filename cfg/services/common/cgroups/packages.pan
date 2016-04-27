unique template common/cgroups/packages;

prefix '/software/packages';
# the profile.d files
"{vsc-cpuset-ugent}" = dict();

# service / init files
"/software/packages" = {
    if (RPM_BASE_FLAVOUR_VERSIONID >= 7) {
        name = 'libcgroup-tools';
    } else {
        name = 'libcgroup';
    };
    SELF[escape(name)] = dict();
    SELF;
};
