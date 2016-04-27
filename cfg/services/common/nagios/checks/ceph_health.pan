unique template common/nagios/checks/ceph_health;

variable CHECK_NAME = "check_ceph_health";
variable SCRIPT_NAME = CHECK_NAME;

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s --id nagios",CHECKS_LOCATION,SCRIPT_NAME));
