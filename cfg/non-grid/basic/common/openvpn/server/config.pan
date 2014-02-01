unique template common/openvpn/server/config;

final variable OPENVPN_SERVER_IP ?=
    error("Variable OPENVPN_SERVER_IP must be defined");
final variable OPENVPN_SERVER_MASK ?= "255.255.0.0";

include {'components/openvpn/config'};
include {'common/openvpn/server/dh'};
include 'common/openvpn/packages';

prefix "/software/components/openvpn/server/default";

"configfile" = "/etc/openvpn/server.conf";
"port" = 1194;
"proto" = "tcp";
"dev" = "tun";
"ca" = "/etc/pki/CA/certs/cachain-ugent.be.pem";
"cert" = "/etc/openvpn/keys/vpn.crt";
"key" = "/etc/openvpn/keys/vpn.key";
"dh" = "/etc/openvpn/keys/dh-4096.pem";
"server" = format("%s %s", OPENVPN_SERVER_IP, OPENVPN_SERVER_MASK);
"ifconfig-pool-persist" = "ipp.txt";
"tls-auth" = "/etc/openvpn/keys/ta.key 0";
"cipher" = "AES-256-CBC";
"comp-lzo" = true;
"max-clients" = 10;
"user" = "nobody";
"group" = "nobody";
"persist-key" = true;
"persist-tun" = true;
#"status" = "/var/log/openvpn-status.log";
"log-append" =  "/var/log/openvpn.log";
"verb" = 5;
#"mute" = 10;


include if_exists('site/openvpn/pushes');

"/software/components/chkconfig/service/openvpn" = nlist("on", "",
                                                         "startstop", true);
