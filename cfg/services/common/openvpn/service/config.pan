unique template common/openvpn/service/config;

include { 
    if(RPM_BASE_FLAVOUR_VERSIONID >= 7) {
        'common/openvpn/service/systemd';
    } else {
        'common/openvpn/service/sysvinit';
    };
};
