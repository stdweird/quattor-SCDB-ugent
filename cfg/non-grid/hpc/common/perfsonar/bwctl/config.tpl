unique template common/perfsonar/bwctl/config;

include { 'components/metaconfig/config' };

include {'common/perfsonar/bwctl/schema'};

prefix "/software/components/metaconfig/services/{/etc/bwctld/bwctld.conf}";

"mode" = 0644;
"owner" = "root";
"group" = "root";
"module" = "general";
"daemon/0" = "bwctld";
"contents/nuttcp_port" = 5006;
"contents/iperf_port" = 5001;
"contents/user" = "bwctl";
"contents/group" = "bwctl";
"contents/control_timeout" = 7200;
"contents/allow_unsync" = true;

prefix "/software/components/metaconfig/services/{/var/lib/bwctl/.bwctlrc}";

"contents" = nlist("iperf_port", 5001,
    "allow_unsync", true);
"module" = "general";
"owner" = "bwctl";
"group" = "bwctl";


# We need this to ensure the bwctl commands run by the beacon accept
# small time schews.
"/software/components/metaconfig/services/{/var/lib/perfsonar/.bwctlrc}" = {
    l = value("/software/components/metaconfig/services/{/var/lib/bwctl/.bwctlrc}");
    l["owner"] = "perfsonar";
    l["group"] = "perfsonar";
    l["daemon"] = list("perfsonarbuoy_bw_master");
    l;
};

prefix "/software/components/metaconfig/services/{/etc/bwctld/bwctld.limits}";



"module" = "perfsonar/bwctl-limits";
"contents/limit/root" = nlist("bandwidth", 1000,
			      "duration", 60,
			      "allow_udp", true,
			      "allow_tcp", true,
			      "allow_open_mode", true);
"contents/limit/jail" = nlist("bandwidth", 1,
			      "duration", 1,
			      "allow_udp", false,
			      "allow_tcp", false,
			      "allow_open_mode", false,
			      "parent", "root");
"contents/limit/vsc" = nlist("parent", "root",
			     "bandwidth", 900);
"contents/limit/ugent" = nlist("parent", "root",
			       "bandwidth", 1000);
"contents/assign/0/network" = "default";
"contents/assign/0/restrictions" = "jail";
"contents/assign/1/network" = "172.0.0.0/11";
"contents/assign/1/restrictions" = "vsc";
"contents/assign/2/network" = "10.141.0.0/16";
"contents/assign/2/restrictions" = "ugent";
"daemon/0" = "bwctld";

"/system/monitoring/hostgroups" = append("bwctl");
