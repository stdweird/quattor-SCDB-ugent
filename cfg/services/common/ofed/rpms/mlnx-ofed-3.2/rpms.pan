unique template common/ofed/rpms/mlnx-ofed-3.2/rpms;

final variable MLX4_LOG_NUM_MGM_ENTRY_SIZE = -1;

variable OS_REPOSITORY_LIST = append("mlnx_ofed_32");

variable OFED_VERSION ?= "3.2";
variable OFED_RELEASE ?= "1.0.1.1.gc05c99f";
variable OFED_DISTRO ?= undef;

variable OFED_KERNEL_MFT_VERSION ?= "4.3.0-25";

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
    # mlnx-ofa_kernel is the new kernel-ib
    # no lock on the rhelXuY bit
    pkg_repl("mlnx-ofa_kernel*", format("%s-OFED.%s.%s.*", OFED_VERSION, OFED_VERSION, OFED_RELEASE), PKG_ARCH_DEFAULT);
    pkg_repl("mlnx-ofa_kernel-modules*", format("%s-OFED.%s.%s.kver.%s", OFED_VERSION, OFED_VERSION, OFED_RELEASE, OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
    pkg_repl("kernel-mft*", format("%s.kver.%s", OFED_KERNEL_MFT_VERSION, OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
    pkg_repl("knem", format("*kver.%s", OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
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
