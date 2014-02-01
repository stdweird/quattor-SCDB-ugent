unique template common/nagios/checks/mem_count;

variable CHECK_NAME = "check_mem_count";
variable SCRIPT_NAME = CHECK_NAME+".sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+"restricted/"+CHECK_NAME + " $ARG1$ $ARG2$");

"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", nlist("all","yes"),
                )
        );
