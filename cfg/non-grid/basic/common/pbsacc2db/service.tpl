unique template common/pbsacc2db/service;

include { 'common/pbsacc2db/config' };
include 'common/pbsacc2db/packages';
include {'components/chkconfig/config'};

"/software/components/chkconfig/service/pbsacc2db" = nlist(
    "startstop", true,
    "on", "",
);

variable COLLECTOR_DB_DB="hpccollector";
variable COLLECTOR_DB_USER="hpccollector";
variable PBSACC2DB_WEB_DB_USER="hpccollector_read_only_user";


include { 'common/postgresql/service' };
"/software/components/postgresql/roles" = npush(
    COLLECTOR_DB_USER, "LOGIN NOCREATEDB NOSUPERUSER NOCREATEROLE PASSWORD '" + COLLECTOR_DB_PASSWORD + "'",
);
"/software/components/postgresql/roles" = npush(
    PBSACC2DB_WEB_DB_USER, "LOGIN NOCREATEDB NOSUPERUSER NOCREATEROLE PASSWORD '" + PBSACC2DB_WEB_DB_PASSWORD + "'",
);


"/software/components/postgresql/databases/" = npush(
    COLLECTOR_DB_DB,nlist("user",COLLECTOR_DB_USER,
    					"installfile","/usr/share/pbsacc2db/db/create_hpc_coll.sql")
);


variable COLLECTOR_HBA = list(
    nlist("host","local",
          "database",list(COLLECTOR_DB_DB),
          "user",list(COLLECTOR_DB_USER),
          "method","trust"),
    nlist("host","local",
          "database",list(COLLECTOR_DB_DB),
          "user",list(PBSACC2DB_WEB_DB_USER),
          "method","password"),
    nlist("host","host",
          "database",list(COLLECTOR_DB_DB),
          "user",list(COLLECTOR_DB_USER),
          "address",HOSTIP+"/32",
          "method","password"),
    nlist("host","host",
          "database",list(COLLECTOR_DB_DB),
          "user",list(COLLECTOR_DB_USER),
          "address","127.0.0.1/32",
          "method","password"),
    nlist("host","host",
          "database",list(COLLECTOR_DB_DB),
          "user",list(PBSACC2DB_WEB_DB_USER),
          "address","127.0.0.1/32",
          "method","password"),
);
"/software/components/postgresql/config/hba" = {
    t=COLLECTOR_HBA;
    foreach (k;v;SELF) {
        t[length(t)]=v;
    };
    t;
};

"/system/monitoring/hostgroups" = append("pbsacc2db_server");
