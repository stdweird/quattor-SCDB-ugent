unique template site/monitoring/logs/aii/receiver;

variable SYSLOG_RELAY ?= undef;
variable SYSLOG_PORT_AII ?= 515;

"/software/components/syslog/directives" = append(
    # Watch out, rsyslog REQUIRES template definitions between double quotes!!!
    '$template RemoteFileAII,"/var/log/remote/%$YEAR%/%$MONTH%/%$DAY%/AII_%FROMHOST%"'
    );
"/software/components/syslog/directives" ={
    # do NOT bind and activate the udp part here
    append('$ModLoad imudp.so'); # has to be UDP 
};


"/software/components/syslog/config" = {
    # set the default ruleset for current block
    prepend(nlist(
        'action', '$RuleSet RSYSLOG_DefaultRuleset'
        ));
    append(nlist(
        'action', '$RuleSet AII'
        ));
    append(nlist(
        "selector", list(nlist(
            "facility","*",
            "priority", "*")),
	    "action",  "-?RemoteFileAII"));
    append(nlist(
        'action', '$InputUDPServerBindRuleset AII' # EL5 and EL6
        ));
    append(nlist(
        'action', format('$UDPServerRun %s', SYSLOG_PORT_AII) # binds and activates
        ));
    append(nlist(
        'action', '$InputTCPServerBindRuleset AII' # EL7 tcp syslog
        ));
    append(nlist(
        'action', format('$InputTCPServerRun %s', SYSLOG_PORT_AII) # binds and activates
        ));
};

# an AII receiver is very likely also a sender
include 'site/monitoring/logs/aii/sender';
