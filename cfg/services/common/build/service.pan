unique template common/build/service;

include 'common/build/packages';

# No environment modules
"/software/packages/{environment-modules}" = null;
        
include 'common/build/clusterbuildrpm';

include 'common/build/rng';
    
include {if (RPM_BASE_FLAVOUR_NAME != 'el5') {'common/build/mock'}};
