unique template common/kibana/kibana3/config;

variable USE_NSS ?= false;
include {
    if(USE_NSS) {
        'common/kibana/kibana3/config_nss'
    } else {
        'common/kibana/kibana3/config_ssl'
    };
};
