unique template common/virtualbox/packages;

prefix "/software/packages";

"/software/packages"=pkg_add("kernel-headers",KERNEL_VERSION_NUM,PKG_ARCH_KERNEL,"multi");
"/software/packages"=pkg_add("kernel-devel",KERNEL_VERSION_NUM,PKG_ARCH_KERNEL,"multi");

"{VirtualBox}" = nlist();
"{dahdi-linux}" = nlist();
