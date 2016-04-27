unique template common/gold/config;
include 'components/gold/config';
variable GOLD_LOG_DIR ?= "/var/log/gold";
variable GOLD_AUTH_KEY ?= undef;
variable GOLD_SERVER ?= undef;
variable GOLD_IS_SERVER ?= { FULL_HOSTNAME == GOLD_SERVER }; 

include { if(GOLD_IS_SERVER) { 'common/gold/server' } }; 

"/software/components/gold/auth_key" = GOLD_AUTH_KEY;

"/software/components/gold/client" = dict(
    "server.host",  GOLD_SERVER,
    "log4perl.appender.Log.filename",GOLD_LOG_DIR+"/gold.log",
);

"/software/components/dirperm/paths" = push(dict(
             "path",    GOLD_LOG_DIR,
             "owner",   "root:apache",
             "perm",    "0770",
             "type",    "d"
            ));
