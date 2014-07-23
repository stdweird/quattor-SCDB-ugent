unique template common/ofed/rpms/1.5.x/qib;


prefix "/software/packages";
"{infinipath-psm}"  = nlist();
"{infinipath-psm-devel}"  = nlist();

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
    pkg_repl("qib", format("*%s", OFED_KERNEL_VERSION_FIXED), PKG_ARCH_DEFAULT);
};

# fixes
"/software/components/symlink/links" = {
    append(nlist(
        "name", "/etc/udev/rules.d/60-ipath.rules",
        "target", "/etc/udev.d/60-ipath.rules.filecopy",
        "exists", false,
        "replace", nlist("all","yes"),
    ));
};

# not provided by home build rpm of inifinipath-psm
variable CONTENT = <<EOF; 
KERNEL=="ipath", MODE="0666"
KERNEL=="ipath[0-9]*", MODE="0666"
KERNEL=="ipath_*", MODE="0600"
KERNEL=="kcopy[0-6][0-9]", NAME="kcopy/%02n", MODE="0666"

EOF

'/software/components/filecopy/services' =
  npush(escape('/etc/udev.d/60-ipath.rules.filecopy'),
        nlist('config',CONTENT,
              'owner','root:root',
              'perms', '0644'));
