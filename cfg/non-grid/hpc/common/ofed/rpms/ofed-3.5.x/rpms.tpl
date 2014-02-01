unique template common/ofed/rpms/ofed-3.5.x/rpms;


include {'quattor/functions/repository'};
variable OS_REPOSITORY_LIST = append("ofed_35");

variable OFED_KERNEL_VERSION ?= KERNEL_VERSION;
variable OFED_KERNEL_APPEND_ARCH ?= true;
variable OFED_KERNEL_VERSION_FIXED ?= {
    txt=snr("-","_",OFED_KERNEL_VERSION);
    if (OFED_KERNEL_APPEND_ARCH && (RPM_BASE_FLAVOUR_NAME == 'el6')) {
        txt=txt+'.'+PKG_ARCH_DEFAULT;
    };
    txt;
};

"/software/packages" = {
    pkg_repl("compat-rdma*", '3.5-'+OFED_KERNEL_VERSION_FIXED, PKG_ARCH_DEFAULT);
};

prefix "/software/packages";
"{ofed-scripts}" = nlist();

"{infinipath-psm}"  = nlist();
"{infinipath-psm-devel}"  = nlist();
"{tmi}" = nlist();

"{libmthca}"  = nlist();
"{libmlx4}"  = nlist();
"{libcxgb3}"  = nlist();

"{libibverbs-utils}"  = nlist();
"{librdmacm-utils}"  = nlist();
"{compat-dapl-utils}"  = nlist();
"{scsi-target-utils}"  = nlist();

"{dapl-utils}"  = nlist();
"{ibacm}"  = nlist();
"{libibcm}"  = nlist();
"{libibmad}"  = nlist();
"{libibumad}"  = nlist();
"{libnes}"  = nlist();
"{libipathverbs}"  = nlist();

"{ibsim}"  = nlist();
"{ibutils}"  = nlist();
"{infiniband-diags}"  = nlist();
"{mstflint}"  = nlist();
"{qperf}"  = nlist();
"{perftest}"  = nlist();
"{srptools}"  = nlist();


# interesting bug in this code wrt mlnx_affinity. followin rpm is reuired for now
"{irqbalance}" = nlist();
