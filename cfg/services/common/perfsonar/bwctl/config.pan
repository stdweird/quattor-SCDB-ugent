unique template common/perfsonar/bwctl/config;

include 'components/metaconfig/config';

include 'metaconfig/perfsonar/bwctl/config';

prefix "/software/components/metaconfig/services/{/etc/bwctld/bwctld.conf}/contents";
"nuttcp_port" = 5006;
"iperf_port" = 5001;
"user" = "bwctl";
"group" = "bwctl";
"control_timeout" = 7200;
"allow_unsync" = true;

prefix "/software/components/metaconfig/services/{/var/lib/bwctl/.bwctlrc}/contents";
"iperf_port" = 5001;
"allow_unsync" = true;

prefix "/software/components/metaconfig/services/{/etc/bwctld/bwctld.limits}/contents";
"limit/root" = dict(
    "bandwidth", 1000,
    "duration", 60,
    "allow_udp", true,
    "allow_tcp", true,
    "allow_open_mode", true,
    );
"limit/jail" = dict(
    "bandwidth", 1,
    "duration", 1,
	"allow_udp", false,
	"allow_tcp", false,
	"allow_open_mode", false,
	"parent", "root",
    );
"limit/vsc" = dict(
    "parent", "root",
    "bandwidth", 900,
    );
"limit/ugent" = dict(
    "parent", "root",
    "bandwidth", 1000,
    );
"assign/0/network" = "default";
"assign/0/restrictions" = "jail";
"assign/1/network" = "172.0.0.0/11";
"assign/1/restrictions" = "vsc";
"assign/2/network" = "10.141.0.0/16";
"assign/2/restrictions" = "ugent";


"/system/monitoring/hostgroups" = append("bwctl");
