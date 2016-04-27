unique template common/gss/rpms/config;

# add repos
variable GSS_REPO_VERSION ?= {
    if(GSS_VERSION == "1.5") {
        "";
    } else {
        "2.0";
    };
};


include format('common/gss/rpms/%s/gpfs', GSS_VERSION);
include format('common/gss/rpms/%s/kernelUpdates', GSS_VERSION);
include format('common/gss/rpms/%s/lsi_sas', GSS_VERSION);
include format('common/gss/rpms/%s/utils', GSS_VERSION);
include format('common/gss/rpms/%s/mellanox', GSS_VERSION);

prefix "/software/packages";
"{kernel-devel}" = dict();
"{kernel-headers}" = dict();
