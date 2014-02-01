unique template common/nagios/checks/multipath;

variable CHECK_NAME = "check-multipath";
variable SCRIPT_NAME = CHECK_NAME+".pl";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+SCRIPT_NAME + " -m 1 -o 2 -l ''");
