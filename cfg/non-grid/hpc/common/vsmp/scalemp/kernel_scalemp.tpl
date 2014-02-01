unique template common/vsmp/scalemp/kernel_scalemp;

# start with removing kernel packages
prefix "/software/packages";
"{kernel*}" = null;
"{kernel}" = null;

"/software/packages"={
    pkg_repl("kernel*",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);

    pkg_repl("kernel-devel",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);
    pkg_repl("kernel-headers",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);
    pkg_repl("kernel-firmware",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);
};



## extra args for SL6, as defined in the set_kernel_params.sh script
variable SCALEMP_KERNEL_RECOMMENDED_ARGS ?= "nohz=off nmi_watchdog=0 log_buf_len=8M highres=off nortsched intel_iommu=off cgroup_disable=memory printk.time=1";
"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };

    txt=txt+SCALEMP_KERNEL_RECOMMENDED_ARGS;
    txt;
};
