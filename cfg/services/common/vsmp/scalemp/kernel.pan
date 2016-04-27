unique template common/vsmp/scalemp/kernel;


variable SCALEMP_KERNEL_TYPE = "scalemp";
variable SCALEMP_KERNEL_VERSION = "2.6.32-504.1.3.el6.vSMP.1";


include { 'common/vsmp/scalemp/kernel_'+ SCALEMP_KERNEL_TYPE};

## SL6 kernel version naming style
"/system/kernel/version" = SCALEMP_KERNEL_VERSION+'.'+PKG_ARCH_DEFAULT;
