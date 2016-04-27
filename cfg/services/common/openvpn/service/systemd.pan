unique template common/openvpn/service/systemd;

variable OPENVPN_CONFIGS ?= OPENVPN_CLIENTS;

"/software/components/systemd/unit" = {
    # defaults are enabled, service and startstop
    # do not set file/only=true; this is a service on its own
    foreach(i;conf;OPENVPN_CONFIGS) {
        name = format('openvpn@%s.service', conf);
        SELF[escape(name)] = dict('file', dict(
            'replace', true,
            'config', dict('includes', list('/lib/systemd/system/openvpn@.service')),
        ));
    };
    SELF;
};
