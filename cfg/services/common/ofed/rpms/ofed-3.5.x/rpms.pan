unique template common/ofed/rpms/ofed-3.5.x/rpms;
include 'quattor/functions/repository';
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
"{ofed-scripts}" = dict();

"{infinipath-psm}"  = dict();
"{infinipath-psm-devel}"  = dict();
"{tmi}" = dict();

"{libmthca}"  = dict();
"{libmlx4}"  = dict();
"{libcxgb3}"  = dict();

"{libibverbs-utils}"  = dict();
"{librdmacm-utils}"  = dict();
"{compat-dapl-utils}"  = dict();
"{scsi-target-utils}"  = dict();

"{dapl-utils}"  = dict();
"{ibacm}"  = dict();
"{libibcm}"  = dict();
"{libibmad}"  = dict();
"{libibumad}"  = dict();
"{libnes}"  = dict();
"{libipathverbs}"  = dict();

"{ibsim}"  = dict();
"{ibutils}"  = dict();
"{infiniband-diags}"  = dict();
"{mstflint}"  = dict();
"{qperf}"  = dict();
"{perftest}"  = dict();
"{srptools}"  = dict();


# interesting bug in this code wrt mlnx_affinity. followin rpm is reuired for now
"{irqbalance}" = dict();
