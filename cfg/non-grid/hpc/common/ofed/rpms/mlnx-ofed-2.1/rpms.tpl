unique template common/ofed/rpms/mlnx-ofed-2.1/rpms;


variable OS_REPOSITORY_LIST = append("mlnx_ofed_21");

variable OFED_VERSION ?= "2.1";
variable OFED_RELEASE ?= "197.g008fbee";
variable OFED_DISTRO ?= 'rhel6u5';

variable OFED_KERNEL_MFT_VERSION ?= "3.5.0";

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
    pkg_repl("kernel-ib", format("%s-%s_OFED.%s.%s", OFED_VERSION, OFED_KERNEL_VERSION_FIXED, OFED_VERSION, OFED_RELEASE), PKG_ARCH_DEFAULT);
    pkg_repl("kernel-mft*", format("%s-%s", OFED_KERNEL_MFT_VERSION, OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
};

prefix "/software/packages";
"{ofed-scripts}" = nlist();

"{libmverbs}" = nlist();

"{libmthca}"  = nlist();
"{libmlx4}"  = nlist();
"{libmlx5}"  = nlist();
"{libcxgb3}"  = nlist();

"{libibverbs-utils}"  = nlist();
"{librdmacm-utils}"  = nlist();
"{dapl-utils}"  = nlist();
#"{compat-dapl-utils}"  = nlist(); # there is a conflict with dapl-utils

"{ibacm}"  = nlist();
"{libibcm}"  = nlist();
"{libibmad}"  = nlist();
"{libibumad}"  = nlist();
"{libnes}"  = nlist();

"{ibsim}"  = nlist();
"{ibutils}"  = nlist();
"{ibutils2}"  = nlist();
"{infiniband-diags}"  = nlist();
"{mstflint}"  = nlist();
"{perftest}"  = nlist();

# dependencies
"{libsysfs}" = nlist();

# interesting bug in this code wrt mlnx_affinity. followin rpm is reuired for now
"{irqbalance}" = nlist();

# 
"{ummunotify}" = nlist();
"{ummunotify-mlnx}" = nlist();
