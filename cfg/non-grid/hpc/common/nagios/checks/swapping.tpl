unique template common/nagios/checks/swapping;

variable CHECK_NAME = "check_swapping";
variable SCRIPT_NAME = CHECK_NAME+".py";

'/software/components/nrpe/options/command' = {
    SELF[CHECK_NAME] = format("%s/%s -w %d -c %d",
			      CHECKS_LOCATION, SCRIPT_NAME, 1000, 1750);
    SELF;
};
