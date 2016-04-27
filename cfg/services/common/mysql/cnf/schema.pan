declaration template common/mysql/cnf/schema;

type mysql_cnf_size = string with match(SELF,"^[0-9]+(M|K)$");
type mysql_cnf_boolean = long with (SELF == 0) || (SELF == 1);

type mysql_cnf_client = {
    'password'    ?   string
    'port'        ?   long = 3306
    'socket'      ?   string = "/var/lib/mysql/mysql.sock"
};

type mysql_cnf_mysqld = {
    'port'        ?   long = 3306
    'datadir'     ?   string = "/var/lib/mysql"
    'socket'      ?   string = "/var/lib/mysql/mysql.sock"
    'user'        ? string = 'mysql'
    'symbolic-links' ? mysql_cnf_boolean
    'skip-locking'    ? mysql_cnf_boolean
    'key_buffer_size' ? mysql_cnf_size
    'max_allowed_packet' ? mysql_cnf_size
    'table_open_cache' ? long
    'sort_buffer_size' ? mysql_cnf_size
    'read_buffer_size' ? mysql_cnf_size
    'read_rnd_buffer_size' ? mysql_cnf_size
    'myisam_sort_buffer_size' ? mysql_cnf_size
    'thread_cache_size' ? long
    'query_cache_size' ? mysql_cnf_size
    'thread_concurrency' ? long

    'skip-networking' ? mysql_cnf_boolean

    'log-bin'     ?   string

    'server-id'   ?   long

    'master-host' ?   string
    'master-user' ?   string
    'master-password' ? string
    'master-port' ? long
    'log-bin' ? string

    'binlog_format' ? string # eg mixed

    'innodb_data_home_dir' ? string # eg = /var/lib/mysql
    'innodb_data_file_path' ? string # eg= ibdata1:2000M;ibdata2:10M:autoextend
    'innodb_log_group_home_dir' ? string # eg = /var/lib/mysql

    'innodb_buffer_pool_size'  ? mysql_cnf_size # eg = 384M
    'innodb_additional_mem_pool_size'  ? mysql_cnf_size # eg = 20M
    'innodb_log_file_size'  ? mysql_cnf_size # eg = 100M
    'innodb_log_buffer_size'  ? mysql_cnf_size # eg = 8M
    'innodb_flush_log_at_trx_commit' ? long # eg = 1
    'innodb_lock_wait_timeout' ? long # eg = 50
};

type mysql_cnf_mysqldump = {
    'quick' ? mysql_cnf_boolean
    'max_allowed_packet' ? mysql_cnf_size
    'user' ? string
    'password' ? string
};

type mysql_cnf_mysql = {
    'no-auto-rehash' ? mysql_cnf_boolean
    'safe-updates' ? mysql_cnf_boolean
};

type mysql_cnf_myisamchk = {
    'key_buffer_size' ? mysql_cnf_size
    'sort_buffer_size' ? mysql_cnf_size
    'read_buffer' ? mysql_cnf_size
    'write_buffer' ? mysql_cnf_size
};
type mysql_cnf_mysqlhotcopy = {
    'interactive-timeout' ? mysql_cnf_boolean
};

type type_mysql_cnf = {
    'client' ? mysql_cnf_client
    'mysqld' ? mysql_cnf_mysqld

    'mysqldump' ? mysql_cnf_mysqldump
    'mysql' ? mysql_cnf_mysql
    'myisamchk' ? mysql_cnf_myisamchk
    'mysqlhotcopy' ? mysql_cnf_mysqlhotcopy
};
