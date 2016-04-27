unique template common/cyanite/config;


variable CYANITE_CARBON_IFACE ?= FULL_HOSTNAME;
variable CYANITE_CARBON_PORT ?= 2013;

variable ELASTICSEARCH_HOST ?= FULL_HOSTNAME;
variable ELASTICSEARCH_PORT ?= 9200;

variable CYANITE_HTTP_IFACE ?= 'localhost';
variable CYANITE_HTTP_PORT ?= 8080;

# cyanite.yaml
prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}';
"module" = "yaml";
"daemons" = dict("cyanite", "restart");

prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/engine';
"rules/default" = list("5s:1h");

prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/api';
"host" = CYANITE_HTTP_IFACE;
"port" = CYANITE_HTTP_PORT;


prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/input/0';
"type" = "carbon";
"host" = CYANITE_CARBON_IFACE;
"port" = CYANITE_CARBON_PORT;
prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/input/1';
"type" = "pickle";
"host" = CYANITE_CARBON_IFACE;
"port" = CYANITE_CARBON_PORT+1;

prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/logging';
"level" = "info";
"console" = true;
"files" = list("/var/log/cyanite/cyanite.log");
# fix a logging bug
"overrides/io.cyanite" = value('/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/logging/level');

prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/store';
"cluster" = CASSANDRA_IFACE;
"keyspace" = 'metric';

prefix '/software/components/metaconfig/services/{/etc/cyanite.yaml}/contents/index';
"type" = "cassandra";
"cluster" = CASSANDRA_IFACE;
"keyspace" = 'cyanite_paths';

# Manual init step: cqlsh < /usr/share/cyanite/schema.cql
