unique template common/nagios/checks/cpu_count_all;

variable CHECK_NAME = "check_cpu_count_all";
variable SCRIPT_NAME = "cpu_count.sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+"restricted/"+CHECK_NAME + " $ARG1$");

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
