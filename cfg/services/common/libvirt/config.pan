unique template common/libvirt/config;
include 'components/chkconfig/config';
prefix "/software/components/chkconfig/service";
"libvirtd" = dict("on", "", "startstop" , true);
"libvirt-guests" = dict("on", "", "startstop" , true);
