unique template common/vsmp/sysctl;

include {'components/sysctl/config'};
"/software/components/sysctl" = {
    if(is_defined(SELF['variables'])) {
        t = SELF['variables'];
    } else {
        t = nlist();
    };

    ## disable-directory-notify
    t["fs.dir-notify-enable"] = "0";
    
    ## shm-setting
    t["kernel.shmall"] = "9999999999999999";
    t["kernel.shmmax"] = "9999999999999999";
    t["kernel.shmmni"] = "9999999999999999";
    
    ## overcommit
    t["vm.overcommit_memory"] = "2"; 
    t["vm.overcommit_ratio"] = "97";
            
    
    SELF['variables'] = t;
    SELF;
};
    