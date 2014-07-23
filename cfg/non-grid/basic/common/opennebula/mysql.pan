unique template common/opennebula/mysql;

prefix "/software/packages";
"{mysql-server}" = nlist();

include 'components/mysql/config';
include 'components/mysql/config-common';

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

prefix "/software/components/chkconfig/service";
"mysqld" = nlist("on", "","startstop", true);
