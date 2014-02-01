unique template common/kibana/service;

include {'common/kibana/packages'};
variable USE_NSS ?= false;
include {
    if(USE_NSS) {
        'common/kibana/config_nss'
    } else {
        'common/kibana/config_ssl'
    };
};
