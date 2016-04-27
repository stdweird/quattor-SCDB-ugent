unique template common/moab/server/database/postgresql;

## postgres settings for moab
include 'common/postgresql/service';
## add rpm
'/software/packages'=pkg_repl('postgresql-odbc','08.04.0200-1.el6','x86_64');
 
variable MOAB_POSTGRESQL_SQL_CREATE ?= '/usr/share/moab/contrib/sql/moab-db-postgresql-create.sql';

###INCREASE PERFORMANCE ON POSTGRES
"/software/components/postgresql/config/main/checkpoint_segments"=6;

"/software/components/postgresql/roles" = npush(
    MOAB_DB_USER, "LOGIN CREATEDB NOSUPERUSER NOCREATEROLE PASSWORD '" + MOAB_DB_PASSWORD + "'",
); 

"/software/components/postgresql/databases/" = npush(
    MOAB_DB_DB,dict("user",MOAB_DB_USER,
                     "installfile",MOAB_POSTGRESQL_SQL_CREATE) 
);


variable MOAB_HBA = list(
    dict("host","local",
          "database",list(MOAB_DB_DB),
          "user",list(MOAB_DB_USER),
          "method","trust"),
    dict("host","host",
          "database",list(MOAB_DB_DB),
          "user",list(MOAB_DB_USER),
          "address","127.0.0.1/32",
          "method","password"),
);  
"/software/components/postgresql/config/hba" = {
    t=MOAB_HBA;
    foreach (k;v;SELF) {
        t[length(t)]=v;
    };
    t;
};

variable MOAB_ODBC_INI = <<EOF;
[ODBC]
Driver = PostgreSQL
Description = PostgreSQL Data Source
Servername = 127.0.0.1  ## not localhost (pg_hba.conf doesn't like it ?)
Port = 5432
Protocol = 8.4

EOF
