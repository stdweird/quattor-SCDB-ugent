unique template common/graphite/carbon/config;

# basedir for storage etc etc
variable CARBON_BASEDIR ?= "/var/lib/carbon";

prefix "/software/packages";
"{python-carbon}" = nlist();

include 'common/graphite/carbon/schema';
bind "/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/contents" = carbon_config;

prefix "/software/components/metaconfig/services/{/etc/carbon/carbon.conf}";
"module" = "graphite/carbon";
"mode" = 0644;

prefix "/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/contents";
"cache/storage_dir" = CARBON_BASEDIR;
"cache/local_data_dir" = format("%s/whisper/", CARBON_BASEDIR);
"cache/whitelists_dir" = format("%s/lists/", CARBON_BASEDIR);

variable CARBON_SERVICE_CACHE ?= if(GRAPHITE_CARBON_CACHE) {"on"} else {"off"};
variable CARBON_SERVICE_RELAY ?= if(GRAPHITE_CARBON_RELAY) {"on"} else {"off"};
variable CARBON_SERVICE_AGGREGATOR ?= if(GRAPHITE_CARBON_AGGREGATOR) {"on"} else {"off"};

include {if(GRAPHITE_CARBON_CACHE) {'common/graphite/carbon/cache'}};
include {if(GRAPHITE_CARBON_RELAY) {'common/graphite/carbon/relay'}};
include {if(GRAPHITE_CARBON_AGGREGATOR) {'common/graphite/carbon/aggregator'}};

prefix "/software/components/chkconfig/service";
"carbon-cache" = nlist(CARBON_SERVICE_CACHE, "", "startstop", true);
"carbon-relay" = nlist(CARBON_SERVICE_RELAY, "", "startstop", true);
"carbon-aggregator" = nlist(CARBON_SERVICE_AGGREGATOR, "", "startstop", true);

# carbon user
"/software/components/accounts/groups/carbon" =
  nlist("gid", 495);

"/software/components/accounts/users/carbon" = nlist(
  "uid", 495,
  "groups", list("carbon"),
  "comment","Carbon daemon user",
  "shell", "/sbin/nologin",
  "homeDir", CARBON_BASEDIR,
);

include { 'components/dirperm/config'};
"/software/components/dirperm/paths" = append(nlist(
    "path",    CARBON_BASEDIR,
    "owner",   "carbon:carbon",
    "perm",    "0755",
    "type",    "d",
    ));
