unique template common/nagios/checks/check_and_restart;

variable SCRIPT_NAME = "check_and_restart_service";
#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);


variable PROC_NAME = "maui";
"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+PROC_NAME,
                "target", "/etc/init.d/"+PROC_NAME,
                "replace", nlist("all","yes"),
                )
        );

'/software/components/nrpe/options/command' = npush("check_"+PROC_NAME,CHECKS_LOCATION+SCRIPT_NAME+ " "+PROC_NAME);

variable PROC_NAME = "moab";
"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+PROC_NAME,
                "target", "/etc/init.d/"+PROC_NAME,
                "replace", nlist("all","yes"),
                )
        );

'/software/components/nrpe/options/command' = npush("check_"+PROC_NAME,CHECKS_LOCATION+SCRIPT_NAME+ " "+PROC_NAME);

variable PROC_NAME = "pbs_server";
"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+PROC_NAME,
                "target", "/etc/init.d/"+PROC_NAME,
                "replace", nlist("all","yes"),
                )
        );

'/software/components/nrpe/options/command' = npush("check_"+PROC_NAME,CHECKS_LOCATION+SCRIPT_NAME+ " "+PROC_NAME);


#######################
#### more of the same, now in eventhandler
#######################

variable CHECK_NAME = "restart_service";
variable SCRIPT_NAME = CHECK_NAME+".pl";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+"eventhandlers/"+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);


'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+SCRIPT_NAME+ " $ARG1$ $ARG2$ $ARG3$ $ARG4$");
