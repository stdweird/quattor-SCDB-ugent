unique template common/libvirt/qemu-kvm/config;

variable WIPE_AUTOSTART_DEFAULT_NETWORK ?= true;
include {if(WIPE_AUTOSTART_DEFAULT_NETWORK) {'common/libvirt/qemu-kvm/wipe_autostart_default_network'}};

# software
variable QEMU_KVM_RHEV ?= false;
"/software/packages" = {
    suff='';
    if(QEMU_KVM_RHEV) {
        suff='-rhev';
    };
    SELF[escape(format("qemu-kvm%s", suff))] = nlist();
    SELF[escape(format("qemu-kvm-tools%s", suff))] = nlist();
    SELF;
};    

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
