unique template common/gold/postgresql;

## setup postgresql database backend for gold


variable GOLD_DB_DBI = 'Pg';
## use IPv4 address of localhost; might pickup IPv6 from /etc/hosts otherwise
variable GOLD_DB_HOST = "127.0.0.1";


include { 'common/postgresql/service' };

"/software/components/postgresql/roles" = npush(
    GOLD_DB_USER, "LOGIN CREATEDB NOSUPERUSER NOCREATEROLE",
); 

"/software/components/postgresql/databases/" = npush(
    GOLD_DB_DB,nlist("user",GOLD_DB_USER)
);
variable GOLD_HBA = list(
    nlist("host","local",
          "database",list(GOLD_DB_DB),
          "user",list(GOLD_DB_USER),
          "method","password"),
    nlist("host","host",
          "database",list(GOLD_DB_DB),
          "user",list(GOLD_DB_USER),
          "address","127.0.0.1/32",
          "method","password"),
);  
"/software/components/postgresql/config/hba" = {
    t=GOLD_HBA;
    foreach (k;v;SELF) {
        t[length(t)]=v;
    };
    t;
};
