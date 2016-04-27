unique template common/nagios/checks/ceph_health_fsload;

variable CHECK_NAME = "check_ceph_health_fsload";
variable SCRIPT_NAME = "ceph-smart_health.py";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s --nagios-report",CHECKS_LOCATION,SCRIPT_NAME));

