unique template common/openvpn/downloadcerts;

## configures retrieval of openvpn certificates with ncm-download

include { 'common/download/service' };

include 'common/openvpn/server/dh';

"/system/monitoring/hostgroups" = {
    foreach (i; cluster; OPENVPN_CLIENTS) {
        append(format("x509_openvpn_%s",cluster));
    };
    SELF;
};

"/software/components/download/files" = {
    SELF[escape("/etc/openvpn/keys/dh-4096.pem")] = null;
    SELF[escape("/etc/openvpn/keys/ta.key")] = null;
    foreach (i; client; OPENVPN_CLIENTS) {
        file = format("/etc/openvpn/%s/ta.key", client);
        dst = format("secure/openvpn/%s/ta.key", client);
        SELF[escape(file)] = create("common/download/auth",
                                    "perm", "0600",
                                    "proxy", true,
                                    "href", dst);
    };
    SELF;
};

"/software/components/download/dispatch" = true;
