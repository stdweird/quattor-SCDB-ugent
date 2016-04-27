unique template common/nagios/checks/master;

variable CHECK_NAME = "check_master";
variable SCRIPT_NAME = CHECK_NAME+".sh";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);
        
'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+SCRIPT_NAME);
