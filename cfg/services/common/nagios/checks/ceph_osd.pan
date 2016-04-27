unique template common/nagios/checks/ceph_osd;

variable CHECK_NAME = "check_ceph_osd";
variable SCRIPT_NAME = CHECK_NAME;
variable CHECK_CEPH_HNAME ?= HOSTNAME;
'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("%s%s --out -H %s --id nagios",CHECKS_LOCATION,SCRIPT_NAME, CHECK_CEPH_HNAME));
