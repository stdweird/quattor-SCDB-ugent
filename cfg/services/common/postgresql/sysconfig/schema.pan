declaration template common/postgresql/sysconfig/schema;

type type_postgresql_sysconfig = {
    'PGENGINE' ? string #eg = '/usr/bin'
    'PGPORT' ? long = 5432
    'PGDATA' ? string = '/var/lib/pgsql/data'
    'PGLOG' ? string # eg = '/var/lib/pgsql/pgstartup.log'

    'PG_OOM_ADJ' ? long # eg. =-17
};
