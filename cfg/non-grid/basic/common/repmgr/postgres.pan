unique template common/repmgr/postgres;


include 'components/postgresql/config';
"/software/components/postgresql/active" = IS_REPMGR_MASTER;

# add pubkeys for postgres user
variable POSTGRES_ADMIN_PUBKEYS ?= undef;
"/software/components/useraccess/users/postgres/ssh_keys" = {
    foreach(idx;pubkey;POSTGRES_ADMIN_PUBKEYS) {
        append(pubkey);
    };
    SELF;
};

# postgres
variable POSTGRESQL_REPMGR_LISTEN_IPS ?= list();
prefix "/software/components/postgresql/config/main";

"listen_addresses" = {
    if (is_defined(SELF)) {
        t=SELF;
    } else {
        t=list('localhost');
    };
    
    foreach(idx;ip;POSTGRESQL_REPMGR_LISTEN_IPS) {
        t=append(t, ip);
    };
    
    t;
};

"wal_level" = "hot_standby";
"archive_mode" = true;
"archive_command" = 'exit 0';
"max_wal_senders" = 10;
"wal_keep_segments" = 5000; # 80 GB required on pg_xlog
"hot_standby" = true;
#"shared_preload_libraries" = 'repmgr_funcs';


variable POSTGRESQL_REPMGR_LISTEN_IPS_CIDR ?= "samehost";
"/software/components/postgresql/config/hba" = {
    t = list(
        nlist(
            "host", "local",
            "database", list("repmgr"),
            "user", list("repmgr"), # there is no repmgr user in OS
            "method", "trust",
            ),
        nlist(
            "host", "host",
            "database", list("repmgr"),
            "user", list("repmgr"),
            "address", "127.0.0.1/32",
            "method", "trust",
            ),
        nlist(
            "host", "host",
            "database", list("repmgr"),
            "user", list("repmgr"),
            "address", POSTGRESQL_REPMGR_LISTEN_IPS_CIDR,
            "method", "trust",
            ),
        nlist(
            "host", "host",
            "database", list("replication"),
            "user", list("all"),
            "address", POSTGRESQL_REPMGR_LISTEN_IPS_CIDR,
            "method", "trust",
            ),
    );
    foreach(idx;h;SELF) {
        t=append(t,h);
    };
    t;
};

prefix "/software/components/postgresql/databases";
"repmgr/user" = "repmgr";
# not supported in v1.2?
#"repmgr/installfile" = format("/usr/pgsql-%s/share/contrib/repmgr.sql", POSTGRESQL_VERSION);

prefix "/software/components/postgresql/roles";
"repmgr" = "SUPERUSER LOGIN";
