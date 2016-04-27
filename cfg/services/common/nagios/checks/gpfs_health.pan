unique template common/nagios/checks/gpfs_health;

variable CHECK_NAME = "check_gpfs_health";
variable SCRIPT_NAME = "gpfs_monitoring.pl";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -a",CHECKS_LOCATION,SCRIPT_NAME));

variable CHECK_NAME = "check_gpfs_heath_inode";
'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -a -l",CHECKS_LOCATION,SCRIPT_NAME));
