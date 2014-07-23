unique template common/libvirt/rpms;

prefix "/software/packages";
"{bridge-utils}" = nlist();

# versionlock libvirt to prevent service failure incase of upgrade
variable LIBVIRT_VERSION ?= "1.2.2-1.el6.ug.rbd.1";
"/software/packages" = pkg_repl("libvirt", LIBVIRT_VERSION, "x86_64");
