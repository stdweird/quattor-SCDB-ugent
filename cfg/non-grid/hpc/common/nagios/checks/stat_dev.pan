unique template common/nagios/checks/stat_dev;

variable CHECK_NAME = "stat_dev";
variable SCRIPT_NAME = "stat_dev.pl";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s $ARG1$",CHECKS_LOCATION,SCRIPT_NAME));

variable CHECK_NAME = "stat_dev_multipath";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -m $ARG1$",CHECKS_LOCATION,SCRIPT_NAME));

