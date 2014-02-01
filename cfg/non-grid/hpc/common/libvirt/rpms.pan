unique template common/libvirt/rpms;

prefix "/software/packages"; 
"{bridge-utils}" = nlist();

# versionlock libvirt to prevent service failure incase of upgrade
variable LIBVIRT_VERSION ?= "1.1.3-1.el6"; 
"/software/packages" = pkg_repl("libvirt", LIBVIRT_VERSION, "x86_64"); 
