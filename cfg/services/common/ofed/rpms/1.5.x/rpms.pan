unique template common/ofed/rpms/1.5.x/rpms;

include format('common/ofed/rpms/1.5.x/el%s',RPM_BASE_FLAVOUR_VERSIONID);


prefix "/software/packages";

"{librdmacm-utils}"  = dict();
"{ibacm}"  = dict();
"{libmlx4}"  = dict();
"{infinipath-psm}"  = dict();
"{libibumad}"  = dict();
"{libipathverbs}"  = dict();
"{libnes}"  = dict();
"{opensm-libs}"  = dict();
"{librdmacm}"  = dict();
"{libibverbs}"  = dict();
"{opensm}"  = dict();
"{mstflint}"  = dict();
"{compat-dapl-utils}"  = dict();
"{libmthca}"  = dict();
"{dapl-utils}"  = dict();
"{compat-dapl}"  = dict();
"{qperf}"  = dict();
"{libcxgb3}"  = dict();
"{libibverbs-utils}"  = dict();
"{ibutils}"  = dict();
"{perftest}"  = dict();
"{srptools}"  = dict();
"{infiniband-diags}"  = dict();
"{dapl}"  = dict();
"{libibcm}"  = dict();
"{scsi-target-utils}"  = dict();
"{libibmad}"  = dict();
"{libibverbs-utils}" = dict();

# fixes
"/software/components/symlink/links" = {
    append(dict(
        "name", "/etc/dat.conf",
        "target", format("/etc/%s/dat.conf",OFED_IS_RDMA_NAME),
        "exists", false,
        "replace", dict("all","yes"),
    ));
    SELF;
};
