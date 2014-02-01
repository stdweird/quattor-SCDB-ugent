unique template common/libvirt/config;

include { 'components/chkconfig/config' };
prefix "/software/components/chkconfig/service";
"libvirtd" = nlist("on", "", "startstop" , true);
"libvirt-guests" = nlist("on", "", "startstop" , true);

