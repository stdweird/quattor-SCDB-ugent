unique template common/nagios/checks/graylog2;

variable CHECK_NAME = "check_lograte";
variable SCRIPT_NAME = CHECK_NAME+".py";

'/software/components/nrpe/options/command' = {
    SELF[CHECK_NAME] = format("%s/%s -w %d -c %d -i %s",
	CHECKS_LOCATION, SCRIPT_NAME, 1200000, 600000, "graylog2");
    SELF;
};
