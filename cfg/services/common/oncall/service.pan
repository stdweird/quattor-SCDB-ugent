unique template common/oncall/service;

variable ONCALL_VARIANT ?= 'icinga';
variable CALENDAR_VARIANT ?= '';
variable SENDING_DOMAIN ?= DEFAULT_DOMAIN;
variable ENABLE_ONCALL ?= true;
include 'common/oncall/rpms/config'+RPM_BASE_FLAVOUR;include 'common/oncall/members';include 'components/cron/config';
"/software/components/cron/entries" = {
    if(ENABLE_ONCALL){
        append(dict("command", format ("/usr/bin/oncallservice --%s",
				    ONCALL_VARIANT),
                	 "user", "root",
	     	         "timing", dict("minute", "*/5"),
	        	 "name", "oncall"));

        append (dict("command", format ("/usr/bin/googlecalendar %s",
				      CALENDAR_VARIANT),
	        	"user", "root",
		        "timing", dict("minute", "0"),
		        "name", "googlecalendar"));
    } else {
        append (dict("command", format ("/usr/bin/googlecalendar %s --silent",
                                      CALENDAR_VARIANT),
                        "user", "root",
                        "timing", dict("minute", "0"),
                        "name", "googlecalendar"));

    };
};
