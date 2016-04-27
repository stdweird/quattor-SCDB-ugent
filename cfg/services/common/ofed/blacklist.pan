unique template common/ofed/blacklist;

@documentation{
    Blacklist modules to be included in initramfs and possibly loaded during boot.
    (Once loaded, service openibd does not verify the loaded modules during start).
}

variable OFED_BLACKLIST_MODULES ?= list("mlx4_core", "mlx4_en", "mlx5_core", "mlx5_ib");


include 'components/filecopy/config';
prefix "/software/components/filecopy/services/{/etc/modprobe.d/quattor_ofed_blacklist.conf}";
"owner" = "root";
"group" = "root";
"backup" = false;
"config" =  {
    txt='';
    foreach(idx;mod;OFED_BLACKLIST_MODULES) {
        txt=format("%sblacklist %s\n", txt, mod);
    };
    txt;
};

# also disable them in grub
"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };

    # works in EL6 and should also work in EL7,
    # but we have in our templates also modprobe. (and no prefix)
    pref = 'rd';
    foreach(idx;mod;OFED_BLACKLIST_MODULES) {
        txt = format("%s %sblacklist=%s", txt, pref, mod);
    };
    txt;
};
