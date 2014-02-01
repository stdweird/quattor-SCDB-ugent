@{ Schemas of all BUOY-MA-related configuration files }

declaration template common/perfsonar/buoy/schema;

final variable BW_DEFS = nlist(
			       "data_dir",
			       "/var/lib/perfsonar/perfsonarbuoy_ma/bwctl",
			       "central_host", "magikarp.cubone.gent.vsc:8570",
			       "timeout", 3600,
			       "archive_dir",
			       "/var/lib/perfsonar/perfsonarbuoy_ma/bwctl/archive",
			       "db", "bwctl",
			       );

final variable OWAMP_DEFS = nlist("data_dir",
				  "/var/lib/perfsonar/perfsonarbuoy_ma/owamp",
				  "central_host", "magikarp.cubone.gent.vsc:8569",
				  "timeout", 3600,
				  "archive_dir",
				  "/var/lib/perfsonar/perfsonarbuoy_ma/owamp/archive",
				  "db", "owamp",
				  );

type nodestring = type_fqdn with exists("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/nodes/" + SELF) ||
    error ("Node specification must exist: " + SELF);

type service_globals = {
    "data_dir" : string
    "central_host" : string
    "db" : string
    "timeout" : long(0..)
    "archive_dir" : string
};

type bw_test = {
    "interval" : long(0..)
    "start_alpha" : long(0..)
    "report_interval" : long(0..)
    "duration" : long(0..) = 60
    "type" : string = "BWTCP"
};

type owp_test = {
    "interval" : double(0..) = 0.1
    "lossthresh" : double(0..) = 10.0
    "session_count" : long(0..) = 10800
    "sample_count" : long(0..) = 600
    "bucket_width" : double(0..) = 0.0001
};

type test_spec = {
    "description" : string
    "tool" : string
    "bw" ? bw_test
    "owamp" ? owp_test
};


type measurement_set = {
    "testspec" : string with exists("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/testspecs/" + SELF) ||
    error ("Test specification must exist: " + SELF)
    "group" : string with exists("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/groups/" + SELF) ||
    error ("Group specification must exist: " + SELF)
    "exclude_self" : boolean = false
    "description" : string
    "addr_type" : string
};

type node = {
    "longname" : string
    "contact_addr" : type_ip
    "test_addr" : type_ip{}
};

type nodehash = node{} with {
    foreach(nodename; n; SELF) {
	if (!is_fqdn(nodename)) {
	    error ("Keys for node hash must be FQDNs: " + SELF);
	};
    };
    true;
};

type group = {
    "description" : string
    "type" : string with match(SELF, "^(STAR|MESH)")
    "hauptnode" ? nodestring
    "nodes" : nodestring[]
    "include_senders" ? type_fqdn[]
    "include_receivers" ? type_fqdn[]
    "senders" ? type_fqdn[]
    "receivers" ? type_fqdn[]
} with SELF["type"] == "STAR" && exists(SELF["hauptnode"]) ||
    SELF["type"] == "MESH" && !exists(SELF["hauptnode"]) ||
    error ("STAR type and hauptnode make sense only when specified together");

type host = {
    "node" : nodestring
};

type type_owmesh = {
    "bindir" : string = "/usr/bin"
    "bwctl" : service_globals
    "owamp" : service_globals
    "var_dir" : string = "/var/lib"
    "user" : string = "perfsonar"
    "group" : string = "perfsonar"
    "verify_peer_addr" : boolean = false
    "central_data_dir" : string = "/var/lib/perfsonar/perfsonarbuoy_ma"
    "central_db_type" : string = "DBI:mysql"
    "central_db_user" : string = "perfsonar"
    "central_db_pass" : string = "7hc4m1"
    "send_timeout" : long = 60
    "testspecs" : test_spec{}
    "nodes" : nodehash
    "localnodes" : nodestring[]
    "hosts" : host{}
    "groups" : group{}
    "measurementsets" : measurement_set{}
    "addrtype" : string[]
};

bind "/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents" = type_owmesh;
