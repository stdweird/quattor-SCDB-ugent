unique template common/mysql/config;

include 'common/mysql/cnf/config';

include 'components/mysql/config';

prefix  "/software/components/mysql";
"serviceName" = ONE_MYSQL_FLAVOUR;

"/software/packages" = {
    SELF[escape(format('%s-server', ONE_MYSQL_FLAVOUR))] = dict();
    SELF;
};
