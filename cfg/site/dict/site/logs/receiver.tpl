@{ Syslog configuration for nodes sending their syslog messages remotely }
@{ Author= Luis Fernando Muñoz Mejías }
@{ Maintainer = Luis Fernando Muñoz Mejías }

unique template site/monitoring/logs/receiver;

include {'components/syslog/config'};

variable SYSLOG_RELAY ?= undef;
variable SYSLOG_PORT ?= 514;

"/software/components/syslog/directives" = append(
    # Watch out, rsyslog REQUIRES template definitions between double quotes!!!
    '$template RemoteFile,"/var/log/remote/%$YEAR%/%$MONTH%/%$DAY%/%HOSTNAME%"'
    );
"/software/components/syslog/directives" ={
    append('$ModLoad imtcp.so');
    append(format('$InputTCPServerRun %s',SYSLOG_PORT));
};


"/software/components/syslog/config" = {
    prepend(
	nlist("selector", list(nlist("facility","*",
		    "priority", "*")),
	    "action",  "-?RemoteFile"));
};

# Compress all raw logs.
"/software/components/cron/entries" = append(
    nlist("command",
	"find /var/log/remote -daystart -mtime +1 -mtime -3 -type f -not -name '*.gz' -exec gzip '{}' ';'",
	"comment", "Compress raw logs",
	"name", "logzip",
	"timing", nlist("hour", "5", "minute", "23")));


variable SYSLOG_AII ?= false;	
include { if(SYSLOG_AII) {'site/monitoring/logs/aii/receiver'}};
