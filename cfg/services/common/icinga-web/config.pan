unique template common/icinga-web/config;

include 'common/icinga-web/packages';

variable ICINGAWEB_DB_USER ?= "icinga_web";
variable ICINGAWEB_DB_DB ?= ICINGAWEB_DB_USER;

include 'common/postgresql/service';

# Create user in postgres
"/software/components/postgresql/roles" = npush(
    ICINGAWEB_DB_USER, format("LOGIN CREATEDB NOSUPERUSER NOCREATEROLE PASSWORD '%s'",
               ICINGAWEB_DB_PASSWORD)
);
 
# Create and populate db
"/software/components/postgresql/databases/" = npush(
    ICINGAWEB_DB_DB, dict("user", ICINGAWEB_DB_USER,
               "installfile", "/usr/share/icinga-web/etc/schema/pgsql.sql")
);

# Configure pg_hba.conf
"/software/components/postgresql/config/hba" = prepend(
    dict("host", "host",
        "database", list(ICINGAWEB_DB_DB),
        "user", list(ICINGAWEB_DB_USER),
        "address", "127.0.0.1/32",
        "method", "password"),
);

"/software/components/postgresql/config/hba" = prepend(
    dict("host", "local",
        "database", list(ICINGAWEB_DB_DB),
        "user", list(ICINGAWEB_DB_USER),
        "method", "trust"),
);

# Configure icinga_web database.xml file
include 'metaconfig/icinga-web/config';

prefix '/software/components/metaconfig/services/{/usr/share/icinga-web/app/config/databases.xml}/contents';

'icinga_db' = dict(
    'dsn', dict(
        'protocol', 'pgsql',
        'hostname', 'localhost',
        'username', ICINGA_DB_USER,
        'password', ICINGA_DB_PASSWORD,
        'port', 5432,
        'database_name', ICINGA_DB_DB,
        ),
    'charset', 'utf8',
    'manager_attributes', dict(
        'attr_model_loading', 'CONSERVATIVE',
        ),
    'caching',  dict(
        'enabled', false,
        'driver', 'apc',
        'use_query_cache', true,
        ),
    'prefix', 'icinga_',
    'use_retained', true,
    'load_models', '%core.module_dir%/Api/lib/database/models/generated',
    'models_directory', '%core.module_dir%/Api/lib/database/models',
    'class', 'IcingaDoctrineDatabase',
);

'icinga_web_db' = dict(
    'dsn', dict(
        'protocol', 'pgsql',
        'hostname', 'localhost',
        'username', ICINGAWEB_DB_USER,
        'password', ICINGAWEB_DB_PASSWORD,
        'port', 5432,
        'database_name', ICINGAWEB_DB_DB,
        ),
    'charset', 'utf8',
    'manager_attributes', dict(
        'attr_model_loading', 'CONSERVATIVE',
        ),
    'caching',  dict(
        'enabled', false,
        'driver', 'apc',
        'use_query_cache', true,
        'use_result_cache', true,
        'result_cache_lifespan', 60,
        ),
    'load_models', '%core.module_dir%/AppKit/lib/database/models/generated',
    'models_directory', '%core.module_dir%/AppKit/lib/database/models',
    'class', 'AppKitDoctrineDatabase',
);
