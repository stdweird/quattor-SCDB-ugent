unique template common/moab/server/database;

## starting from v7, moab nows can benefit from a database for some analysis

variable MOAB_DATABASE_BACKEND ?= 'postgresql';

variable MOAB_DB_USER ?= "moab";
variable MOAB_DB_DB ?= 'Moab';
include 'common/moab/server/database/'+MOAB_DATABASE_BACKEND;
variable MOAB_PROFILING = list('user','group','qos','class','account','node');

"/software/components/moab" = {
    foreach(k;v;MOAB_PROFILING) {
        if ( !exists(SELF[v]) || !is_defined(SELF[v]) ) {
            SELF[v] = dict();
        };
        if ( !exists(SELF[v]['DEFAULT']) || !is_defined(SELF[v]['DEFAULT']) ) {
            SELF[v]['DEFAULT'] = list();
        };

        SELF[v]['DEFAULT']=append(SELF[v]['DEFAULT'],'ENABLEPROFILING=TRUE');
    };
    SELF;
};

"/software/components/moab/main/usedatabase"='ODBC';


## odbc ini files
## odbcinst.ini files come from unixODBC and eg odbc-postgres
## odbc.ini is empty from unixODBC
variable MOAB_ODBC_INI ?= '';
include 'components/filecopy/config';
variable MOAB_ODBC_INI = MOAB_ODBC_INI + "UserName = "+MOAB_DB_USER+"\n";
variable MOAB_ODBC_INI = MOAB_ODBC_INI + "Password = "+MOAB_DB_PASSWORD+"\n";
variable MOAB_ODBC_INI = MOAB_ODBC_INI + "Database = "+MOAB_DB_DB+"\n";

'/software/components/filecopy/services' =
  npush(escape('/etc/odbc.ini'),
        dict('config',MOAB_ODBC_INI,
              'owner','root:root',
              'perms', '0600'));
include 'components/symlink/config';
"/software/components/symlink/links" = push(
    dict(
            "name", MOAB_HOME+"/dsninfo.dsn",
            "target", "/etc/odbc.ini",
            "replace", dict("all","yes"),
    )
);
