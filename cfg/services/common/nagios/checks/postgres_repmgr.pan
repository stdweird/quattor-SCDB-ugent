unique template common/nagios/checks/postgres_repmgr;


# in the postgres repo
prefix "/software/packages";
"{check_postgres}" = dict();

variable REPMGR_TRUSTED_IP ?= undef;
'/software/components/nrpe/options/command' = {
    cmd=format("sudo -u postgres /usr/bin/check_postgres.pl --dbname %s --dbuser %s -H %s --showtime=0 --action ", 
               "repmgr", "repmgr", REPMGR_TRUSTED_IP);
    querycmd=format("%s custom_query --warning $ARG1$ --critical $ARG2$ --query ",cmd);
    SELF["check_postgres_repmgr"] = format("%s $ARG1$", cmd);
    
    query=format("select EXTRACT(EPOCH FROM NOW() - last_monitor_time)  AS result FROM repmgr_%s.repl_status", REPMGR_CLUSTER); 
    SELF["check_postgres_repmgr_monitortime"] = format("%s '%s'", querycmd, query);

    query=format("select EXTRACT(EPOCH FROM time_lag)  AS result FROM repmgr_%s.repl_status", REPMGR_CLUSTER); 
    SELF["check_postgres_repmgr_timelag"] = format("%s '%s'", querycmd, query);

    SELF;
};

include 'components/sudo/config';

"/software/components/sudo/privilege_lines" = append(
        dict("cmd", "/usr/bin/check_postgres.pl",
              "user", value("/software/components/nrpe/options/nrpe_user"),
              "run_as", "postgres",
              "host", "ALL",
              "options", "NOPASSWD:"));
