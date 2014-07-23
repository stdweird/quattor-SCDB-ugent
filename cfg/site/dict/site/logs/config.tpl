@{ Basic syslog configuration for every Quattor-managed node }
@{ Author= Luis Fernando Muñoz Mejías }
@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

unique template site/monitoring/logs/config;

include {'components/syslog/config'};
include {'components/chkconfig/config'};

"/software/components/syslog/daemontype" = "rsyslog";

"/software/components/syslog/directives" = {
    append("$ModLoad imklog");
    append("$ModLoad imuxsock");
    append("$SystemLogRateLimitInterval 5");
    append("$SystemLogRateLimitBurst 200");
};

"/software/components/syslog/fullcontrol" = true;

"/software/components/syslog/config" = {
    append(
	nlist("selector",
	    list(
		nlist("facility", "*",
		    "priority", "info"),
		nlist("facility", "mail",
		    "priority", "none"),
		nlist("facility", "authpriv",
		    "priority", "none"),
		nlist("facility", "cron",
		    "priority", "none"),
		nlist("facility", "uucp",
		    "priority", "*"),
		nlist("facility", "news",
		    "priority", "crit")),
	    "action",  "-/var/log/messages"));
    append(
	nlist("selector", list(nlist("facility", "authpriv",
		    "priority", "*")),
	    "action", "/var/log/secure"));
    append(
	nlist("selector", list(nlist("facility", "local7",
		    "priority", "*")),
	    "action", "/var/log/boot.log"));
    append(
	nlist("selector", list(nlist("facility", "cron",
		    "priority", "*")),
	    "action", "-/var/log/cron.log"));
};

prefix "/software/components/chkconfig/service";

"rsyslog" = nlist("on", "", "startstop", true);
"syslog" = nlist("off", "", "startstop", true);

"/software/packages" = pkg_del("sysklogd");
