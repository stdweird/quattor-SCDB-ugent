unique template common/nagios/checks/mem_count_all;

variable CHECK_NAME = "check_mem_count_all";
variable SCRIPT_NAME = "mem_count.sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+"restricted/"+CHECK_NAME + " $ARG1$");

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
