unique template common/nagios/checks/check_and_restart_opensm;

variable SCRIPT_NAME = "check_and_restart_service";
#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

variable PROC_NAME = "opensmd";
variable SERVICE_NAME = {if(is_defined(OFED_IS_RDMA) && OFED_IS_RDMA) {"opensm"} else {"opensmd"}};

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+PROC_NAME,
                "target", format("/etc/init.d/%s",SERVICE_NAME),
                "replace", dict("all","yes"),
                )
        );
'/software/components/nrpe/options/command' = npush("check_"+PROC_NAME,CHECKS_LOCATION+SCRIPT_NAME+ " "+PROC_NAME);
