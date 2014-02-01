unique template common/vsmp/scalemp/primary;

variable VSMP_SCALEMP_IP_POLICY = 'exact';


## modify some hardware aspects of the master node due to added secondary
"/" = {
    foreach(idx;sl;VSMP_SCALEMP_CONFIG["slaves"]) {
        ## CPUS
        path='/hardware/cpu';
        foreach(idx;cpu;value(format("%s%s:%s",SCALEMP_PROFILE_PREFIX,sl,path))) {
            SELF['hardware']['cpu']=append(SELF['hardware']['cpu'],cpu);
        };

        ## network cards
        path='/hardware/cards/nic';
        foreach(name;nic;value(format("%s%s:%s",SCALEMP_PROFILE_PREFIX,sl,path))) {
            ippath=format("%s%s:%s/%s",SCALEMP_PROFILE_PREFIX,sl,"/system/network/interfaces",name);
            ip=undef;
            if (path_exists(ippath)) {
                ip=value(ippath);
            };

            idx=1;
            while(exists(SELF['hardware']['cards']['nic'][name])) {
                mm=matches(name,"^(.*)([0-9]+)$");
                name=format("%s%s",mm[1],to_string(to_long(mm[2]) +1));
            };
            nic['boot']=false;
            SELF['hardware']['cards']['nic'][name]=nic;

            ## ip
            if (is_defined(ip)) {
                if(VSMP_SCALEMP_IP_POLICY == 'exact') {
                    SELF['system']['network']['interfaces'][name]=ip;
                } else {
                    error(format("Unknown VSMP_SCALEMP_IP_POLICY %s defined",VSMP_SCALEMP_IP_POLICY));
                }

            }
        };
    };

    ## replace emX devices with ethX-1 ?

    SELF;
};
