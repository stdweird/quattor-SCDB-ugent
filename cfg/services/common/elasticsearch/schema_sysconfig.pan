declaration template common/elasticsearch/schema_sysconfig;

type es_sysconfig = {
    "ES_USER" : string = "elasticsearch"
    "ES_HOME" : string = "/usr/share/elasticsearch"

    "LOG_DIR" : string = "/var/log/elasticsearch"
    "DATA_DIR" : string = "/var/lib/elasticsearch"
    "WORK_DIR" : string = "/tmp/elasticsearch"
    "CONF_DIR" : string = "/etc/elasticsearch"

    "ES_INCLUDE" ? string 
    "ES_HEAP_SIZE" : string = "2g"
    "ES_HEAP_NEWSIZE" ? string 
    "ES_DIRECT_SIZE" ? string
    "ES_JAVA_OPTS" ? string
    "ES_CLASSPATH" ? string
    "MAX_OPEN_FILES" : long(1..) = 65535
    "MAX_LOCKED_MEMORY" ? string # eg unlimited

    "JAVA_HOME" ? string
};

bind "/software/components/metaconfig/services/{/etc/sysconfig/elasticsearch}/contents" = es_sysconfig;
