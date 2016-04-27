unique template common/ofed/ipoib_tuning;

"/software/components/grub/args" = {
    if(is_defined(SELF)) {
        txt=SELF+" ";
    } else {
        txt='';
    };

    txt=txt+"intel_idle.max_cstate=0 processor.max_cstate=1";
    txt;
};

include 'common/sysctl/service';
"/software/components/metaconfig/services/{/etc/sysctl.conf}/contents" = {
    foreach (k;v;create('common/sysctl/struct/ipoib_tuning')) {
        SELF[k]=v;
    };
    SELF;
};
