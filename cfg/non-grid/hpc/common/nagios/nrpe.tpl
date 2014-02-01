unique template common/nagios/nrpe;

## add nrpe rpms
include 'common/nagios/nrpe/packages';

"/software/components/chkconfig/service/nrpe/on" = "";
"/software/components/chkconfig/service/nrpe/startstop" = true;


## add nrpe config
include { 'monitoring/nagios/nrpe/config' };



## add nrpe checks + commands
include { 'common/nagios/checks/checks' };

'/software/components/nrpe/options/dont_blame_nrpe' = true;

## sudo settings
##    user    host = (run_as_user) OPTIONS: command
include { 'common/sudo/config' };
"/software/components/sudo/privilege_lines" = {
    append(nlist("user","nagios",
            "run_as","ALL",
            "host","ALL",
            "cmd",CHECKS_LOCATION+"restricted/",
            "options", "NOPASSWD:"));
    append(nlist("user","nagios",
            "run_as","ALL",
            "host","ALL",
            "cmd","/usr/sbin/dmidecode",
            "options", "NOPASSWD:"));
};

"/software/components/nrpe/dependencies/pre" = append("accounts");

