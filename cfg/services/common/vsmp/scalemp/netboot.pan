unique template common/vsmp/scalemp/netboot;

## use this is you want to pxeboot scalemp
## - if included, works only with pxeboot!

## add this for each host
variable VSMP_SCALEMP_NETBOOT_SUFFIX_PREFIX ?= 'vsmp';
final variable AII_DHCP_ADDOPTIONS = {
    #suff=format("%s.%s",VSMP_SCALEMP_NETBOOT_SUFFIX_PREFIX,VSMP_SCALEMP_CONFIG["master"]);
    suff='scalempnetboot'; ## same for both modes ## no underscore, underscore triggers tftp prefix mechanism 
    if (path_exists("/system/aii/dhcp/options/addoptions")) {
        val=value("/system/aii/dhcp/options/addoptions"); 
        if (is_defined(val)){
            error("no supported: existing addoptions, current value "+val);
        }; 
    }; 
    txt=format('if option vendor-class-identifier = "ScaleMP" { filename "/pxelinux.0.%s"; } else { filename "/vsmp/pxelinux.0.%s"; }',suff,suff);
    return(txt);
};

## reenforce it
"/system/aii/dhcp/options/addoptions" = AII_DHCP_ADDOPTIONS;

## anaconda is a mess with more then 1 CPU
## - remove this part if you need the extra devices during anaconda (and system is stable)
##  - this disables scanning the pci using the acpi info from the fake scalemp bios
##   - ignore any devices that are not primary, makes the whole thing work like a charm
"/system/aii/nbp/pxelinux/append" = "maxcpus=1 pci=noacpi";
"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };
    
    txt=txt+"-maxcpus=1 -pci=noacpi";
    txt;
};


'/software/components/vsmp/pxesuffixprefix' = VSMP_SCALEMP_NETBOOT_SUFFIX_PREFIX;
