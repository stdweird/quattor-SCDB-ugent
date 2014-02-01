unique template common/named/base_config;

prefix  "/software/components/metaconfig/services/{/etc/named.conf}/contents";

"options" = {
    foreach(k;v;create("common/named/basic_options")) {
        SELF[k]=v;
    };
    SELF;
};
"logging/channels/default_debug" = nlist (
    "severity", "dynamic",
    "file", "data/named.run");
"logging/category" = nlist();
"includes" = append("/etc/named.rfc1912.zones");

include {if_exists('site/named/zones')};
include {if_exists('site/named/acls')};
include {if_exists('site/named/forwarders')};

