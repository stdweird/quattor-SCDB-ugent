@{
    Configures OpenVPN servers
}
unique template common/openvpn/server/service;

include 'common/openvpn/server/config';

variable OPENVPN_CONFIGS = 'server';

include 'common/openvpn/service/config';

"/software/components/openvpn/dependencies/pre" = append("download");
