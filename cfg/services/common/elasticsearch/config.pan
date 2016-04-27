unique template common/elasticsearch/config;

variable ELASTICSEARCH_GATEWAY_TYPE ?= "fs";

variable ES_HTTP_IP ?= '127.0.0.1';

include 'metaconfig/elasticsearch/config';

prefix "/software/components/metaconfig/services/{/etc/elasticsearch/elasticsearch.yml}/contents/threadpool";
"bulk/size" = length(value("/hardware/cpu"));
"bulk/type" = "fixed";
"bulk/queue_size" = 500;
"search/size" = length(value("/hardware/cpu"));
"search/type" = "fixed";
"search/queue_size" = 500;
"index/size" = length(value("/hardware/cpu")) * value("/hardware/cpu/0/cores");
"index/type" = "fixed";
"index/queue_size" = 1000;

prefix "/software/components/metaconfig/services/{/etc/elasticsearch/elasticsearch.yml}/contents";
"index/refresh" = 10;
"indices/memory/index_buffer_size" = "50%";
"index/translog/flush_threshold_ops" = 100000;
"index/number_of_replicas" = 1;
"bootstrap/mlockall" = true;
"network/host" = ES_HTTP_IP;
"node/name" = FULL_HOSTNAME;

# ES account/group
prefix "/software/components/accounts";
"users/elasticsearch" = dict("comment", "Elasticsearch account",
    "homeDir", "/var/lib/elasticsearch",
    "shell", "/sbin/nologin",
    "password", "!",
    "uid", 3002,
    "groups", list("elasticsearch"),
);
"groups/elasticsearch/gid" = 3002;

# sysconfig settings
include 'common/elasticsearch/sysconfig';

# sysctl settings for VM
include 'common/sysctl/service';
"/software/components/metaconfig/services/{/etc/sysctl.conf}/contents/vm.max_map_count" = "262144";
