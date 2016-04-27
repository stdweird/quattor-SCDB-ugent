unique template common/nscd/config;
include 'components/nscd/config';
include 'common/nscd/packages';

## when using BLCR, disable all shared settings
## this is still better then disabling blcr all together
variable NSCD_USE_BLCR ?= false;
"/software/components/nscd/" = {
    if(NSCD_USE_BLCR) {
        t=list("passwd","group","hosts");
        foreach(i;v;t) {
            if (!is_defined(SELF[v])) {
                SELF[v]=dict();
            };
            SELF[v]['shared'] = 'no';
        };
    };
    SELF;
};
