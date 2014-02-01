unique template common/graphite/carbon/cache;

"/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/daemon" = append("carbon-cache");

bind "/software/components/metaconfig/services/{/etc/carbon/storage-schemas.conf}/contents" = carbon_cache_storage_schemas;

prefix "/software/components/metaconfig/services/{/etc/carbon/storage-schemas.conf}";
#"daemon/0" = "carbon-cache"; # no restart, file scanned every 60 seconds
"module" = "graphite/storage-schemas";
"mode" = 0644;

prefix "/software/components/metaconfig/services/{/etc/carbon/storage-schemas.conf}/contents";

"main/0" = nlist(
    "name", "carbon",
    "pattern" , '^carbon\.',
    "retentions", list("60:90d"),
    );

# last rule, change the index!!
"main/1" = nlist(
    "name", "default",
    "pattern" , ".*",
    "retentions", list("60s:7d", "1h:90d"),
    );

    