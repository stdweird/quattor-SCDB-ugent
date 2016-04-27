unique template common/sysctl/config;

prefix "/software/components/metaconfig/services/{/etc/sysctl.conf}";
"module" = "tiny";
"daemons" = { 
    if(RPM_BASE_FLAVOUR_VERSIONID >= 7 ){
        dict("systemd-sysctl", "restart");
    } else {
        null;
    };  
};

variable SYSCTL_CONFIGS ?= { 
    append(format('common/sysctl/struct/el%s', RPM_BASE_FLAVOUR_VERSIONID));
    
    append('common/sysctl/struct/shm');
    append('common/sysctl/struct/msg');
    append('common/sysctl/struct/common');
    append('common/sysctl/struct/arp_cache'); # large clusters only? or whole VSC network?
    
    if(is_defined(USE_BLCR) && USE_BLCR) {
        append('common/sysctl/struct/blcr');
    };

    # return SELF and extra configs    
    return(merge(SELF, SYSCTL_EXTRA_CONFIGS));
};


"/software/components/metaconfig/services/{/etc/sysctl.conf}/contents" = {
    res=dict();
    foreach (idx;tpl;SYSCTL_CONFIGS) {
        foreach (k;v;create(tpl)) {
            res[k]=v;
        };
    };
    res;
};
