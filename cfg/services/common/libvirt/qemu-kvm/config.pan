unique template common/libvirt/qemu-kvm/config;

variable WIPE_AUTOSTART_DEFAULT_NETWORK ?= true;
include {if(WIPE_AUTOSTART_DEFAULT_NETWORK) {'common/libvirt/qemu-kvm/wipe_autostart_default_network'}};

# software

variable QEMU_KVM_RHEV ?= false;
variable QEMU_KVM_VERSION ?= 0;

"/software/packages" = {
    suff='';
    if(QEMU_KVM_RHEV) {
        suff='-rhev';
    };
    if(to_boolean(QEMU_KVM_VERSION)) {
        pkg_repl(format("qemu-kvm%s",suff), QEMU_KVM_VERSION, 'x86_64');
        pkg_repl(format("qemu-kvm-tools%s",suff), QEMU_KVM_VERSION, 'x86_64');
        pkg_repl(format("qemu-img%s",suff), QEMU_KVM_VERSION, 'x86_64');
    } else {
        SELF[escape(format("qemu-kvm%s", suff))] = dict();
        SELF[escape(format("qemu-kvm-tools%s", suff))] = dict();
        SELF[escape(format("qemu-img%s", suff))] = dict();
        SELF;
    };
};    

"/software/packages" = {
    if (LIBVIRT_MAJORVERSION > 0) {
        SELF[escape("libvirt-daemon-kvm")] = dict();
    };
    SELF;  
}; 

# user/groups
include 'common/libvirt/qemu-kvm/user';

# services
include 'components/chkconfig/config';
prefix "/software/components/chkconfig/service";
"ksm" = dict("on", "", "startstop" , true);
"ksmtuned" = dict("on", "", "startstop" , true);
