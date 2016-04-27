unique template common/nagios/checks/check_IB;

variable CHECK_NAME = "check_ib";
variable SCRIPT_NAME = "check_IB";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);
      
'/software/components/nrpe/options/command' = npush(CHECK_NAME,+CHECKS_LOCATION+SCRIPT_NAME);
