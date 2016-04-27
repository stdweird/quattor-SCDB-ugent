unique template common/cassandra/config;

# cassandra.yaml
prefix '/software/components/metaconfig/services/{/etc/cassandra/conf/cassandra.yaml}';
"module" = "yaml";
"daemons" = dict("cassandra", "restart");

prefix '/software/components/metaconfig/services/{/etc/cassandra/conf/cassandra.yaml}/contents';

variable CASSANDRA_IFACE ?= FULL_HOSTNAME;
variable CASSANDRA_NODES ?= list(FULL_HOSTNAME);
variable CASSANDRA_CLUSTER ?= 'graphite';

"cluster_name" = CASSANDRA_CLUSTER;
"num_tokens" = 256;

"listen_address" = CASSANDRA_IFACE;
"rpc_address" = CASSANDRA_IFACE;
"endpoint_snitch" = "RackInferringSnitch";

"commitlog_sync" = "periodic";
"commitlog_sync_period_in_ms" = 10000;
"write_request_timeout_in_ms" = 20000;
"partitioner" = "org.apache.cassandra.dht.Murmur3Partitioner";

"data_file_directories" = list('/var/lib/cassandra/data');
"commitlog_directory" = "/var/lib/cassandra/commitlog";
"saved_caches_directory" = "/var/lib/cassandra/saved_caches";
"start_native_transport" = true;
"native_transport_port" = 9042;

prefix '/software/components/metaconfig/services/{/etc/cassandra/conf/cassandra.yaml}/contents/seed_provider/0';
"class_name" =  "org.apache.cassandra.locator.SimpleSeedProvider";

"parameters/0/seeds" = join(',', CASSANDRA_NODES);
