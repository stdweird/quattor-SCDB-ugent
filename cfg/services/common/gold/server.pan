unique template common/gold/server;

variable GOLD_DATABASE ?= "postgresql";

variable GOLD_DB_DBI ?= undef;
variable GOLD_DB_DB ?= 'gold';
variable GOLD_DB_USER  ?= 'gold';
variable GOLD_DB_HOST ?= "localhost";
include 'common/gold/'+GOLD_DATABASE;
"/software/components/gold/server" = dict(

    "server.host",  GOLD_SERVER,
    "log4perl.appender.Log.filename",GOLD_LOG_DIR+"/goldd.log",

    "database.datasource", "DBI:"+GOLD_DB_DBI+":database="+GOLD_DB_DB+";host="+GOLD_DB_HOST,
    "database.user", GOLD_DB_USER,
    "database.password", GOLD_DB_PASSWORD,
);
