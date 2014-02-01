@{
    Template listing the variables that will control the GPFS versions
    in the nodes.
}
@{
    Author = Luis Fernando Muñoz Mejías <Luis.Munoz@UGent.be>
    Maintainer = Luis Fernando Muñoz Mejías <Luis.Munoz@UGent.be>
}

unique template rpms/gpfs;

variable PKG_ARCH_GPFS ?= PKG_ARCH_DEFAULT;

variable GPFS_LANG_LOCAL ?= "en_US";

variable GPFS_VERSION_BASE ?= "3.4.0";
variable GPFS_VERSION_MAIN ?= "3.5.0";
variable GPFS_VERSION_UPDATE ?= "13";
variable GPFS_VERSION ?= GPFS_VERSION_MAIN+"-"+GPFS_VERSION_UPDATE;
variable GPFS_KERNEL_VERSION ?= format("%s.%s", KERNEL_VERSION, PKG_ARCH_GPFS);
variable GPFS_KERNEL_VERSION_FIXED ?= snr("-","_",GPFS_KERNEL_VERSION);
variable COMPAT_STDCPLUSPLUS_VERSION ?= "3.2.3-69.el6";