unique template common/elasticsearch/config;

variable ELASTICSEARCH_GATEWAY_TYPE ?= "fs";

variable ES_HTTP_IP ?= '127.0.0.1';


prefix "/software/components/metaconfig/services/{/etc/elasticsearch/elasticsearch.yml}";

"module" = "yaml";
"contents/gateway" = {
    SELF["type"] = ELASTICSEARCH_GATEWAY_TYPE;
    if (ELASTICSEARCH_GATEWAY_TYPE == "fs") {
        SELF["fs"] = "/var/lib/elasticsearch";
    };
    SELF;
};

prefix "/software/components/metaconfig/services/{/etc/elasticsearch/elasticsearch.yml}/contents/threadpool";

"search/size" = length(value("/hardware/cpu"));
"search/type" = "fixed";
"search/queue_size" = 100;
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

prefix "/software/components/accounts";
"users/elasticsearch" = nlist("comment", "Elasticsearch account",
    "homeDir", "/var/lib/elasticsearch",
    "shell", "/sbin/nologin",
    "password", "!",
    "uid", 3002,
    "groups", list("elasticsearch"),
);
"groups/elasticsearch/gid" = 3002;

include {
    v = "/software/components/metaconfig/services/{/etc/elasticsearch/elasticsearch.yml}";
    if (value(v + "/contents/gateway/type") == 'fs') {
	   'common/elasticsearch/nfs';
    };
};

prefix "/software/components/metaconfig/services/{/etc/sysconfig/elasticsearch}";
"module" = "tiny";
"mode" = 0644;
"daemon/0" = "elasticsearch";
prefix "/software/components/metaconfig/services/{/etc/sysconfig/elasticsearch}/contents";
"ES_HEAP_SIZE" = {
        s = value("/hardware/ram/0/size");
        s = s*length(value("/hardware/ram"));
        s = (s*3)/(1024*5); # 60%
        format("%dg", s);
};
"ES_JAVA_OPTS" = "-Des.monitor.jvm.enabled=false";
"ES_HEAP_NEWSIZE" = "1g";
"ES_DIRECT_SIZE" = "1g";
"MAX_LOCKED_MEMORY" = "unlimited";

