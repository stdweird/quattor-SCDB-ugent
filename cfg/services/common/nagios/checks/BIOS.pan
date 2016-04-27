unique template common/nagios/checks/BIOS;

variable CHECK_NAME = "check_BIOS";
variable SCRIPT_NAME = CHECK_NAME+".sh";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+"restricted/"+SCRIPT_NAME + " $ARG1$");

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
