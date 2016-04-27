unique template common/vsmp/scalemp/kernel_homebrew;

"/software/packages"=pkg_add("kernel",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL,"multi");
"/software/packages"=pkg_add("kernel-devel",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL,"multi");
"/software/packages"=pkg_repl("kernel-headers",SCALEMP_KERNEL_VERSION,PKG_ARCH_KERNEL);
