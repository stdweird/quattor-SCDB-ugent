unique template common/rdac/config;

## for now, only set the grub entry.
## assuming manual installation of rdac (make install/mmpupdate/...)
## set grub entry to current kernel + mpp initrd 
## -does grubby complain when initrd is none-existing?
variable RDAC_KERNEL_VERSION ?= KERNEL_VERSION;

## grub support is not ok. eg need --copy-default option to grubby
include {'components/grub/config'}; 
"/software/components/grub/kernels" = {
    error("grub support is not ok. eg need --copy-default option to grubby");
    initrd="mpp-"+RDAC_KERNEL_VERSION+".img";
    kernelpath="vmlinuz-"+RDAC_KERNEL_VERSION;
    toadd=nlist("kernelpath",kernelpath,"initrd",initrd,"kernelargs","ro root=LABEL=/ selinux=0");
    if(is_list(SELF)) {
        ind=-1;
        foreach(i;v;SELF) {
            if(match(v['kernelpath'],kernelpath)) {
                ind=i;
            }
        };
        if (ind < 0) {
            append(SELF,toadd);
        } else {
            SELF[ind]['initrd']=initrd;
        }
    } else {
        append(SELF,toadd);
    };
    SELF;
};
