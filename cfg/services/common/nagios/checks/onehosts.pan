unique template common/nagios/checks/onehosts;

variable CHECK_NAME = "check_onehosts";
variable SCRIPT_NAME = CHECK_NAME+".sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("sudo %s/restricted/%s",CHECKS_LOCATION,SCRIPT_NAME));

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
