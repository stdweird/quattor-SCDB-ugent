unique template common/elasticsearch/sysconfig;

include 'common/elasticsearch/schema_sysconfig';

prefix "/software/components/metaconfig/services/{/etc/sysconfig/elasticsearch}";
"module" = "tiny";
"mode" = 0644;
"daemons" = dict("elasticsearch", "restart");

prefix "/software/components/metaconfig/services/{/etc/sysconfig/elasticsearch}/contents";
"ES_HEAP_SIZE" = format("%dg", ( total_ram() ) / (1024 * 2)); # 50%
"ES_JAVA_OPTS" = "-Des.monitor.jvm.enabled=false";
"ES_HEAP_NEWSIZE" = "1g";
"ES_DIRECT_SIZE" = "1g";
"MAX_LOCKED_MEMORY" = "unlimited";
"JAVA_HOME" = "/usr/lib/jvm/jre-1.8.0"; # openjdk 1.8.0 support
