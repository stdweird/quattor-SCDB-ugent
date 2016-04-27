unique template common/opennebula/mysql;

include 'common/mysql/service';

prefix "/software/components/mysql/servers/one";
"host" = FULL_HOSTNAME; # localhost is added by component
"adminpwd" = OPENNEBULA_MYSQL_ADMIN;
"adminuser" = "root";

prefix "/software/components/mysql/databases/opennebula";
"server" = "one";
"users/oneadmin/password" = OPENNEBULA_MYSQL_ONEADMIN;
"users/oneadmin/rights" = list("ALL PRIVILEGES"); 
"createDb" = false; # if false, run script
"initScript/file" = "/dev/null";

# MySQL/MariaDB dump db conf
"/software/components/metaconfig/services/{/etc/my.cnf.d/opennebula.cnf}" = create("common/mysql/cnf/metaconfig");

include 'common/mysql/cnf/schema';
bind "/software/components/metaconfig/services/{/etc/my.cnf.d/opennebula.cnf}/contents" = type_mysql_cnf;

prefix "/software/components/metaconfig/services/{/etc/my.cnf.d/opennebula.cnf}/contents";
"mysqldump/user" = "oneadmin";
"mysqldump/password" = OPENNEBULA_MYSQL_ONEADMIN;
