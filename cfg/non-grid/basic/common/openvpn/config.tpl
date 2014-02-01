unique template common/openvpn/config;

include { 'components/openvpn/config' };

variable OPENVPN_CLIENTS_SUBNET ?= undef;
variable OPENVPN_CLIENTS ?= list();
variable OPENVPN_CLIENTS_CONFIG ?= {
    if(is_defined(OPENVPN_CLIENTS_SUBNET)) {
        subnet=format('.%s',OPENVPN_CLIENTS_SUBNET);
    } else {
        subnet='';
    };
    t=nlist();
    foreach(i;client;OPENVPN_CLIENTS) {
        t[client]=nlist(
            'client', true,
            'configfile', '/etc/openvpn/'+client+'.conf',
            'dev', 'tun',
            'proto', 'tcp',
            'remote',list(format('%s%s 1194',client,subnet)),
            'resolv-retry','infinite',
            'nobind',true,
            'persist-key',true,
            'persist-tun',true,
            'ca', "/etc/pki/CA/certs/cachain-ugent.be.pem",
            'cert', "/etc/openvpn/keys/vpn.crt",
            'key',"/etc/openvpn/keys/vpn.key",
            'tls-auth', format("/etc/openvpn/%s/ta.key 1", client),
            'cipher','AES-256-CBC',
            'comp-lzo',true,
            'verb',3,
            );
    };
    t;
};



"/software/components/openvpn/clients" ?= OPENVPN_CLIENTS_CONFIG;

variable USE_DOWNLOAD_CERTS ?= true;

include { if(USE_DOWNLOAD_CERTS) { 'common/openvpn/downloadcerts' } };
