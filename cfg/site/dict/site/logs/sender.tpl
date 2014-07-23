@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}
@{ Syslog configuration for nodes sending their syslog messages remotely }

unique template site/monitoring/logs/sender;

include {'components/syslog/config'};

include {'site/monitoring/logs/config'};

@use{
    type = type_fqdn
    default = Current Quattor server
    note = Server receiving all the syslog messages for this host.
}
variable SYSLOG_RELAY ?= QUATTOR_SERVER;

@use{
    type = type_port
    default = 514 (syslog port)
    note = Server port waiting for the messages
}
variable SYSLOG_PORT ?= 514;

@use{
    type = type_port
    default = 514 (syslog port)
    note = Server port to send the messages too
}
variable SYSLOG_RELAY_PORT ?= 514;

"/software/components/syslog/directives" = {
  append("$ActionQueueFileName remote");
  append("$WorkDirectory /var/spool/rsyslog");
  append("$ActionQueueMaxDiskSpace 30g");
  append("$ActionQueueMaxDiskSpace 1g");
  append("$ActionQueueSaveOnShutdown on");
  append("$ActionQueueType LinkedList");
  append("$ModLoad immark.so");
  append("$MarkMessagePeriod 1800");
  append('$template LOGSTASH,"<%PRI%>1 %timegenerated:::date-rfc3339% %HOSTNAME% %syslogtag% - %APP-NAME%: %msg:::drop-last-lf%\n"');
};

"/software/components/dirperm/paths" = append(
    nlist(
        "path", "/var/spool/rsyslog",
        "owner", "root:root",
        "perm", "0750",
        "type", "d"
    )
);

"/software/components/syslog/config" =  {
    l = list(
        nlist(
            "selector", list(nlist(
                "facility","*",
                "priority", "*")),
            "action",  format("@@%s:%d;LOGSTASH",
                SYSLOG_RELAY, SYSLOG_RELAY_PORT)),
        nlist(
            "action", format(':hostname, !isequal, "%s" ~',
                HOSTNAME)
        ));
    merge(l, SELF);
};

"/software/components/syslog/dependencies/pre" = append("dirperm");

variable SYSLOG_AII ?= false;   
include { if(SYSLOG_AII) {'site/monitoring/logs/aii/config'}};
