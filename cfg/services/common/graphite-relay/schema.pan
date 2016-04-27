unique template common/graphite-relay/schema;

type graphite_relay_hash = {
    "replicas" : long (1..) = 10
} = dict();

type graphite_relay_relay_backendstrategy =string with match(SELF, '^(graphite.relay.backend.strategy.ConsistentHash|graphite.relay.backend.strategy.RoundRobin|graphite.relay.backend.strategy.Broadcast)$');
type graphite_relay_relay_overflowhandler =string with match(SELF, '^(graphite.relay.overflow.BitchingOverflowHandler|graphite.relay.overflow.LoggingOverflowHandler)$');

type graphite_relay_relay = {
    "hostbuffer": long(1..) = 1000
    "port" : long(1..) = 2002
    "reconnect" : long(1..) = 2

    "backendstrategy" : graphite_relay_relay_backendstrategy
    "overflowhandler" : graphite_relay_relay_overflowhandler

    "backends" : string[]
} = dict();

type graphite_relay_overflow = {
    "directory" : string
};


type graphite_relay = {
    "hash" : graphite_relay_hash
    "relay" : graphite_relay_relay
    "overflow" ? graphite_relay_overflow
};

type graphite_relay_sysconfig = {
    "GR_USER" : string = "carbon"
    "CONF_FILE" : string = "/etc/graphite-relay/graphite-relay.properties"
    "LOG_CONF_FILE" : string = "/etc/graphite-relay/graphite-relay.log4j"
    "GR_JAVA_OPTS" ? string
};

bind "/software/components/metaconfig/services/{/etc/graphite-relay/graphite-relay.properties}/contents" = graphite_relay;
bind "/software/components/metaconfig/services/{/etc/sysconfig/graphite-relay}/contents" = graphite_relay_sysconfig;
