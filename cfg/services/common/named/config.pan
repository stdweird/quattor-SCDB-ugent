unique template common/named/config;

prefix "/software/components/accounts";
"kept_users/named" = "";
"kept_groups/named" = "";

include 'components/chkconfig/config';
"/software/components/chkconfig/service/named" =
        dict("on","","startstop",true);

include 'components/named/config';
"/software/components/named/start" = true; # yes, also here. ncm-named wil turn it off otherwise

include 'metaconfig/named/config';

prefix  "/software/components/metaconfig/services/{/etc/named.conf}/contents";
"logging/channels/default_debug" = dict(
    "severity", "dynamic",
    "file", "data/named.run",
    );
"logging/category" = dict();

# forwarders and dnssec don't play nice
variable NAMED_DNSSEC ?= false;
"options/dnssec-enable" = NAMED_DNSSEC;
"options/dnssec-validation" = NAMED_DNSSEC;

"/system/monitoring/hostgroups" = append("named_servers");

variable NAMED_CACHING ?= false;
variable NAMED_CONFIG_TYPE ?= {
    if(NAMED_CACHING) {
        'cache_config';
    } else {
        'base_config';
    };
};
include format('common/named/%s',NAMED_CONFIG_TYPE);
# adapt /etc/resolv.conf, set localhost first (in case named is down)
"/software/components/named/use_localhost" = true;
"/system/network/nameserver" = {
    foreach(idx;fwd;value("/software/components/metaconfig/services/{/etc/named.conf}/contents/options/forwarders")) {
        append(fwd);
    };
    SELF;
};
# stupid component
"/software/components/named/servers" = value("/system/network/nameserver");
