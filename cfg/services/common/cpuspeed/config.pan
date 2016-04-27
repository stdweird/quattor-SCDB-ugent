unique template common/cpuspeed/config;

"/software/components/chkconfig/service" = {
    if(RPM_BASE_FLAVOUR_VERSIONID >= 7) {
        name= 'cpupower';
    } else {
        name = 'cpuspeed';
    };    
    SELF[name] = dict("on", "", "startstop", true);
    SELF;
};
