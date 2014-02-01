@{
    Template listing boot options for all SL6 nodes.
}

unique template config/core/boot;

variable HOST_IS_VM ?= {
    if(match(value("/hardware/serialnumber"),'^kvm/')) {
        return(true);
    };
    return(false);
};

"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };

    txt=txt+"crashkernel=128M@16M nohz=off";
    if (HOST_IS_VM) {
        txt=txt+" clocksource_failover=acpi_pm";
    };
    txt;
};

