unique template common/gss/rpms/2.0/mellanox;

variable OS_REPOSITORY_LIST = append("gss/mellanox");

variable OFED_VERSION ?= "2.1";
variable OFED_KERNEL_RELEASE ?= "1.0.6.1.g75b4801";
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
    pkg_repl("kmod-kernel-mft-mlnx", format("%s-*", OFED_KERNEL_MFT_VERSION), PKG_ARCH_DEFAULT);
    pkg_repl("kmod-mlnx-ofa_kernel", format("%s-OFED.%s.%s.%s", OFED_VERSION, OFED_VERSION, OFED_KERNEL_RELEASE, OFED_DISTRO), PKG_ARCH_DEFAULT);
    pkg_repl("mlnx-ofa_kernel", format("%s-OFED.%s.%s.%s", OFED_VERSION, OFED_VERSION, OFED_KERNEL_RELEASE, OFED_DISTRO), PKG_ARCH_DEFAULT);
    pkg_repl("mlnx-ofa_kernel-devel", format("%s-OFED.%s.%s.%s", OFED_VERSION, OFED_VERSION, OFED_KERNEL_RELEASE, OFED_DISTRO), PKG_ARCH_DEFAULT);
};

prefix "/software/packages";
"{ofed-scripts}" = dict();

"{libmthca}"  = dict();
"{libmlx4}"  = dict();
"{libmlx5}"  = dict(); 
"{libcxgb3}"  = dict();

"{libibverbs-utils}"  = dict();
"{librdmacm-utils}"  = dict();
"{dapl-utils}"  = dict();
#"{compat-dapl-utils}"  = dict(); # there is a conflict with dapl-utils

"{ibacm}"  = dict();
"{libibcm}"  = dict();
"{libibmad}"  = dict();
"{libibumad}"  = dict();
"{libnes}"  = dict();

"{ibsim}"  = dict();
"{ibutils}"  = dict();
"{ibutils2}"  = dict();
"{infiniband-diags}"  = dict();
"{mstflint}"  = dict();
"{perftest}"  = dict();

# dependencies
"{libsysfs}" = dict();

# interesting bug in this code wrt mlnx_affinity. followin rpm is reuired for now
"{irqbalance}" = dict();

# gpfs needs the libverbs.so symlink from libibverbs-devel
"{libibverbs-devel}"  = dict();
