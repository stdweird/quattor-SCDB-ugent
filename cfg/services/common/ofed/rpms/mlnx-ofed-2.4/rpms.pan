unique template common/ofed/rpms/mlnx-ofed-2.4/rpms;

final variable MLX4_LOG_NUM_MGM_ENTRY_SIZE = -1;

variable OS_REPOSITORY_LIST = append("mlnx_ofed_24");

variable OFED_VERSION ?= "2.4";
variable OFED_RELEASE ?= "1.0.4.1.g13136df";
variable OFED_DISTRO ?= undef;

variable OFED_KERNEL_MFT_VERSION ?= "3.8.0";

variable OFED_KERNEL_VERSION ?= KERNEL_VERSION;
variable OFED_KERNEL_APPEND_ARCH ?= true;
variable OFED_KERNEL_VERSION_FIXED ?= {
    txt=snr("-","_",OFED_KERNEL_VERSION);
    if (OFED_KERNEL_APPEND_ARCH && (RPM_BASE_FLAVOUR_VERSIONID >= 6)) {
        txt=txt+'.'+PKG_ARCH_DEFAULT;
    };
    txt;
};

"/software/packages" = {
    pkg_repl("kernel-ib", format("%s-%s_OFED.%s.%s", OFED_VERSION, OFED_KERNEL_VERSION_FIXED, OFED_VERSION, OFED_RELEASE), PKG_ARCH_DEFAULT);
    pkg_repl("kernel-mft*", format("%s-%s", OFED_KERNEL_MFT_VERSION, OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
    pkg_repl("knem", format("*-%s", OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
};

prefix "/software/packages";
"{ofed-scripts}" = dict();

"{libmlx4}"  = dict();
"{libmlx5}"  = dict();

"{libibverbs-utils}"  = dict();
"{librdmacm-utils}"  = dict();
"{dapl-utils}"  = dict();
#"{compat-dapl-utils}"  = dict(); # there is a conflict with dapl-utils

"{ibacm}"  = dict();
"{libibcm}"  = dict();
"{libibmad}"  = dict();
"{libibumad}"  = dict();
"{libvma}" = dict();

"{ibsim}"  = dict();
"{ibutils}"  = dict();
"{ibutils2}"  = dict();
"{infiniband-diags}"  = dict();
"{mstflint}"  = dict();
"{perftest}"  = dict();

# dependencies
"{libsysfs}" = dict();

# interesting bug in this code wrt mlnx_affinity. following rpm is required for now
"{irqbalance}" = dict();

# 
"{mxm}" = dict();
"{hcoll}" = dict();
