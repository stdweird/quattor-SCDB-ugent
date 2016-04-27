unique template common/nagios/checks/batchhold_jobs;

variable CHECK_NAME = "check_batchholds";
variable SCRIPT_NAME = CHECK_NAME+".sh";
    
'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+SCRIPT_NAME + " $ARG1$");
