unique template common/mysql/service;

variable ONE_MYSQL_FLAVOUR ?= {
    if (RPM_BASE_FLAVOUR_VERSIONID >= 7) {
        "mariadb";
    } else {
        "mysqld";
    };
};

include 'common/mysql/config';

"/software/components/chkconfig/service" = {
    SELF[ONE_MYSQL_FLAVOUR] = dict("on", "", "startstop", true);
    SELF;
};

"/system/monitoring/hostgroups" = append("mysql-servers");
