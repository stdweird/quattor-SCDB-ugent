@{ Template containing NRPE checks for PerfSONAR measurements }
unique template common/nagios/checks/perfsonar;

'/software/components/nrpe/options/command' = {
    SELF["check_throughput"] =
    "/opt/perfsonar_ps/nagios/bin/check_throughput.pl -u http://localhost:8085/perfsonar_PS/services/pSB  -t 10 -s '$ARG1$' -d '$ARG2$' -w '$ARG3$' -c '$ARG4$' -r 14400";
    SELF["check_latency"] = "/opt/perfsonar_ps/nagios/bin/check_owdelay.pl -u http://localhost:8085/perfsonar_PS/services/pSB  -t 10 -s '$ARG1$' -d '$ARG2$' -w '$ARG3$' -c '$ARG4$' -r 120";
    SELF;
};
