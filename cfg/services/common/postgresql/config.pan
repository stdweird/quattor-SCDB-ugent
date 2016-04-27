unique template common/postgresql/config;

include 'components/postgresql/config';

# These templates are setup for 9+ postgres rpm releases that have slightly different file locations etc

# to start the postgresql server as a separate server, change the following name
# don't forget to modify the chkconfig entries to reflect this
variable POSTGRESQL_VERSION ?= "9.2";
variable POSTGRESQL_SERVICENAME ?= "postgresql-"+POSTGRESQL_VERSION;
include 'components/chkconfig/config';
"/software/components/chkconfig/service/" = {
    SELF[POSTGRESQL_SERVICENAME] = dict(
        "on", "",
        "startstop",true,
    );
    SELF;
};


# default values, make sure you know what you're doing here. (or check the component for the behaviour)
prefix "/software/components/postgresql";
"pg_dir" = "/var/lib/pgsql/"+POSTGRESQL_VERSION;
"pg_port" = "5432";
"pg_version" = POSTGRESQL_VERSION;
"pg_engine" = "/usr/pgsql-"+POSTGRESQL_VERSION+"/bin/";
"pg_script_name"=POSTGRESQL_SERVICENAME;


# empty value of postgres_conf and pg_hba 
# will result in using whatever is available (ie mostly default)
variable POSTGRESQL_LARGE_MEMORY_LIMIT = 12*GB;
variable POSTGRESQL_CONFIG_MAIN_LARGE_MEMORY_TUNING ?= dict(
    "shared_buffers", "6GB",
    "temp_buffers", "32MB",
    "work_mem", "4MB",
    "maintenance_work_mem", "64MB",
);

variable POSTGRESQL_CONFIG_MAIN_DEFAULT ?= dict(
    "max_connections", 100,
    "log_destination", 'stderr',
    "logging_collector", true,
    "log_directory", 'pg_log',
    "log_filename", 'postgresql-%a.log',
    "log_truncate_on_rotation", true,
    "log_rotation_age", '1d',
    "log_rotation_size", 0,
    "log_min_messages", 'error',
    "datestyle", 'iso, mdy',
    "lc_messages", 'en_US.UTF-8',
    "lc_monetary", 'en_US.UTF-8',
    "lc_numeric", 'en_US.UTF-8',
    "lc_time", 'en_US.UTF-8',
    "default_text_search_config", 'pg_catalog.english',
    "port", to_long(value('/software/components/postgresql/pg_port')),
);

variable POSTGRESQL_CONFIG_MAIN ?= {
    t = POSTGRESQL_CONFIG_MAIN_DEFAULT;
    # add the large mem tuning for nodes with large amount of ram
    if (total_ram() > POSTGRESQL_LARGE_MEMORY_LIMIT) {
        foreach(k;v;POSTGRESQL_CONFIG_MAIN_LARGE_MEMORY_TUNING) {
            t[k]=v;
        }
    };
    t;
};
"config/main" ?= POSTGRESQL_CONFIG_MAIN;

# these are the usual defaults. should be last in list!
variable POSTGRESQL_CONFIG_HBA_DEFAULT = list(
    dict("host","local",
          "database",list("all"),
          "user",list("all"),
          "method","peer"),
    dict("host","host",
          "database",list("all"),
          "user",list("all"),
          "address","127.0.0.1/32",
          "method","ident"),
    dict("host","host",
          "database",list("all"),
          "user",list("all"),
          "address","::1/128" ,
          "method","ident"),
);
variable POSTGRESQL_CONFIG_HBA ?= POSTGRESQL_CONFIG_HBA_DEFAULT;

"config/hba" = POSTGRESQL_CONFIG_HBA;

# everything now is listed as processed by component: 

# 1. roles (a user is a role with LOGIN added)
# dict(name, attributes)
# add --> PASSWORD \\\'passwd\\\' <-- to set the passwd

# needs shm tuning
include 'common/sysctl/service';
