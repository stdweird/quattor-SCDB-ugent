unique template common/ofed/rpms/1.5.x/rpms;

include format('common/ofed/rpms/1.5.x/el%s',RPM_BASE_FLAVOUR_VERSIONID);


prefix "/software/packages";

"{librdmacm-utils}"  = nlist();
"{ibacm}"  = nlist();
"{libmlx4}"  = nlist();
"{infinipath-psm}"  = nlist();
"{libibumad}"  = nlist();
"{libipathverbs}"  = nlist();
"{libnes}"  = nlist();
"{opensm-libs}"  = nlist();
"{librdmacm}"  = nlist();
"{libibverbs}"  = nlist();
"{opensm}"  = nlist();
"{mstflint}"  = nlist();
"{compat-dapl-utils}"  = nlist();
"{rds-tools}"  = nlist();
"{libmthca}"  = nlist();
"{dapl-utils}"  = nlist();
"{compat-dapl}"  = nlist();
"{qperf}"  = nlist();
"{libcxgb3}"  = nlist();
"{libibverbs-utils}"  = nlist();
"{ibutils}"  = nlist();
"{perftest}"  = nlist();
"{ibsim}"  = nlist();
"{srptools}"  = nlist();
"{infiniband-diags}"  = nlist();
"{dapl}"  = nlist();
"{libibcm}"  = nlist();
"{scsi-target-utils}"  = nlist();
"{libibmad}"  = nlist();
"{libibverbs-utils}" = nlist();

# fixes
"/software/components/symlink/links" = {
    append(nlist(
        "name", "/etc/dat.conf",
        "target", format("/etc/%s/dat.conf",OFED_IS_RDMA_NAME),
        "exists", false,
        "replace", nlist("all","yes"),
    ));
    SELF;
};
