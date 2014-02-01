unique template common/nagios/checks/powervault;

variable CHECK_NAME = "check_md3X";
variable SCRIPT_NAME = CHECK_NAME+'.pl';

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("sudo %s%s -H $ARG1$ $ARG2$",CHECKS_LOCATION,SCRIPT_NAME));

variable CHECK_NAME = "check_md3X_perfdata";
variable SCRIPT_NAME = CHECK_NAME+'.pl';
'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("sudo %s%s -H $ARG1$ $ARG2$",CHECKS_LOCATION,SCRIPT_NAME));

