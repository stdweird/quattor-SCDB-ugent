unique template common/vsmp/scalemp/kernel_scalemp;

# start with removing kernel packages
prefix "/software/packages";
"{kernel*}" = null;
"{kernel}" = null;

"/software/packages" = {
    pkg_repl("kernel*",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);

    SELF[escape("kernel-devel")] = dict();
    SELF[escape("kernel-headers")] = dict();
    SELF[escape("kernel-firmware")] = dict();
    
    SELF;
};



## extra args for SL6, as defined in the set_kernel_params.sh script
variable VSMP_SCALEMP_ISOLCPUS ?= true;
# default 2
variable VSMP_SCALEMP_RPC_TCP_THREADS ?= 8;
variable SCALEMP_KERNEL_RECOMMENDED_ARGS ?= "nohz=off nmi_watchdog=0 log_buf_len=8M highres=off nortsched intel_iommu=off cgroup_disable=memory printk.time=1 clocksource=tsc";
"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };

    txt=txt+SCALEMP_KERNEL_RECOMMENDED_ARGS;

    txt=txt+format(" sunrpc.tcp_slot_table_entries=%d", VSMP_SCALEMP_RPC_TCP_THREADS);

    if (VSMP_SCALEMP_ISOLCPUS) {
        newcores=cores_in_hardware(value("/hardware"));
        # start with 1st slave cpu (start to count from 0; so VSMP_SCALEMP_ORIGCORES -1 +1)
        txt=txt+format(" isolcpus=%d-%d", VSMP_SCALEMP_ORIGCORES, newcores-1);
    };

    txt;
};
