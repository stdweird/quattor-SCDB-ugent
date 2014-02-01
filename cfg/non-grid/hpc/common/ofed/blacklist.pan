unique template common/ofed/blacklist;


variable OFED_BLACKLIST_MODULES ?= list("mlx4_en");


include {'components/filecopy/config'};
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


