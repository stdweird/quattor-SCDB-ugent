unique template common/libvirt/qemu-kvm/config;

variable WIPE_AUTOSTART_DEFAULT_NETWORK ?= true;
include {if(WIPE_AUTOSTART_DEFAULT_NETWORK) {'common/libvirt/qemu-kvm/wipe_autostart_default_network'}};

# software
prefix "/software/packages";
"{qemu-kvm}" = nlist(); 
"{qemu-kvm-tools}" = nlist(); # no deps on qemu-kvm ...

"/software/packages" = {
    if (LIBVIRT_MAJORVERSION > 0) {
        SELF[escape("libvirt-daemon-kvm")] = nlist();
    };
    SELF;  
}; 

# user/groups
include 'common/libvirt/qemu-kvm/user';

# services
include { 'components/chkconfig/config' };
prefix "/software/components/chkconfig/service";
"ksm" = nlist("on", "", "startstop" , true);
"ksmtuned" = nlist("on", "", "startstop" , true);
