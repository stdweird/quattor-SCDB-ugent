unique template common/pam/service;

## don't use the defaults file. (although the 1.4.0 man page suggests otherwise)
variable PAM_USE_DEFAULTS  ?= false;
include 'components/pam/config';
include {
    if(PAM_USE_DEFAULTS) {
        return('common/pam/defaults');
    } else {
        return(null);
    };
};
include 'common/pam/config';
