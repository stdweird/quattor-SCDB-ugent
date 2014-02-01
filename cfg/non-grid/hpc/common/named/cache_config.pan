unique template common/named/cache_config;

variable NAMED_CACHE_FORWARDERS ?= error('A list of IPs to forward the requests to.');
# if list is empty, localhost only
variable NAMED_CACHE_CLIENTS ?= list();

prefix  "/software/components/metaconfig/services/{/etc/named.conf}/contents";

"acls/clients" = {
    append('127.0.0.1');
    foreach(idx;cl;NAMED_CACHE_CLIENTS) {
        append(cl);
    };
    SELF;
};
"options/forward" = "only";
"options/forwarders" =  NAMED_CACHE_FORWARDERS;
"options/allow-query" = list("clients");
"options/max-cache-size" = 4*1024*1024 ;
"options/empty-zones-enable" = true;

