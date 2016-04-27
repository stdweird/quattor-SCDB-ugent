unique template common/libvirt/rpms;

prefix "/software/packages";
"{bridge-utils}" = dict();

# versionlock libvirt to prevent service failure incase of upgrade
variable LIBVIRT_VERSION ?= "1.2.10-1.el6.ug.rbd.1";
#variable LIBVIRT_VERSION ?= "0.10.2-46.el6_6.2";

"/software/packages" = pkg_repl("libvirt*", LIBVIRT_VERSION, "x86_64");
