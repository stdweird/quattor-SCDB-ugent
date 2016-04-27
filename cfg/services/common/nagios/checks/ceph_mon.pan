unique template common/nagios/checks/ceph_mon;

variable CHECK_NAME = "check_ceph_mon";
variable SCRIPT_NAME = CHECK_NAME;
variable CHECK_CEPH_HNAME ?= HOSTNAME;
'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s -I %s -H %s --id nagios",CHECKS_LOCATION,SCRIPT_NAME, HOSTNAME, CHECK_CEPH_HNAME));

