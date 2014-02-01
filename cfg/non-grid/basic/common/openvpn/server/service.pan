@{
    Configures OpenVPN servers
}
unique template common/openvpn/server/service;

include 'common/openvpn/server/config';

"/software/components/openvpn/dependencies/pre" = append("download");
