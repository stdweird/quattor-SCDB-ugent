unique template common/nagios/checks/gpfs_health;

variable CHECK_NAME = "check_gpfs_health";
variable SCRIPT_NAME = CHECK_NAME+".sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -d $ARG1$ -m $ARG2$ -x inode",CHECKS_LOCATION,SCRIPT_NAME));

variable CHECK_NAME = "check_gpfs_heath_inode";
'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -d $ARG1$ -m $ARG2$",CHECKS_LOCATION,SCRIPT_NAME));
