unique template common/oncall/service;

variable ONCALL_VARIANT ?= 'icinga';
variable CALENDAR_VARIANT ?= '';
variable SENDING_DOMAIN ?= DEFAULT_DOMAIN;
variable ENABLE_ONCALL ?= true;


include { 'common/oncall/rpms/config'+RPM_BASE_FLAVOUR };

include {'common/oncall/members'};

include {'components/cron/config'};


"/software/components/cron/entries" = {
    if(ENABLE_ONCALL){
        append(nlist("command", format ("/usr/sbin/oncallservice.py --%s",
				    ONCALL_VARIANT),
                	 "user", "root",
	     	         "timing", nlist ("minute", "*/5"),
	        	 "name", "oncall"));
    
        append (nlist ("command", format ("/usr/sbin/googlecalendar.py %s",
				      CALENDAR_VARIANT),
	        	"user", "root",
		        "timing", nlist ("minute", "0"),
		        "name", "googlecalendar"));
    } else {
        append (nlist ("command", format ("/usr/sbin/googlecalendar.py %s --silent",
                                      CALENDAR_VARIANT),
                        "user", "root",
                        "timing", nlist ("minute", "0"),
                        "name", "googlecalendar"));

    };
};
