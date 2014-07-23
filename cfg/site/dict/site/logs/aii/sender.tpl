@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}
@{ Syslog configuration for nodes sending their syslog messages remotely }

unique template site/monitoring/logs/aii/sender;

"/software/components/syslog/directives" = {
    append('$template LOGSTASHAII,"<%PRI%>1 %timegenerated:::date-rfc3339% %HOSTNAME% %syslogtag% - %APP-NAME%: %msg:::drop-last-lf%\n"');
};

"/software/components/syslog/config" =  {
    sender = nlist(
        "selector", list(nlist(
            "facility","*",
            "priority", "*")),
        "action",  format("@@%s:%d;LOGSTASHAII",
            SYSLOG_RELAY, SYSLOG_RELAY_PORT)
        );

    l=list();
    foreach(idx;val;SELF) {
        if (exists(val["action"]) && match(val["action"], '.*BindRuleset AII.*')) {
            append(l,sender);
        };
        append(l,val);
    };
    l;
};

