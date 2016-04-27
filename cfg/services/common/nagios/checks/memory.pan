unique template common/nagios/checks/memory;

variable CHECK_NAME = "check_mem";
variable SCRIPT_NAME = CHECK_NAME+".pl";
variable CHECK_MEM_WARNING ?= {
    if (exists(WN_CONFIG_SITE)) {
	"97,60";
    } else {
	"95,50";
    };
};
variable CHECK_MEM_CRITICAL ?= {
    if (exists(WN_CONFIG_SITE)) {
	"99,80";
    } else {
	"99,70";
    };
};

'/software/components/nrpe/options/command' = {
    SELF[CHECK_NAME] = format("%s/%s -w %s -c %s",
			      CHECKS_LOCATION, SCRIPT_NAME,
			      CHECK_MEM_WARNING, CHECK_MEM_CRITICAL);
    SELF;
};
