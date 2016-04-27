@{ Generates the owmesh.conf file needed for BUOY
masters. Unfortunately a lot of filecopy here.}

unique template common/perfsonar/buoy/mesh;

include 'metaconfig/perfsonar/buoy/mesh';


@{ Hash that contains the hosts to be listed in owmesh.conf }
variable PERFSONAR_TEST_HOSTS ?= error ("PERFSONAR_TEST_HOSTS must be already defined");

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents";

"addrtype" = list("VSC", "OS");
"bwctl" = BW_DEFS;
"owamp" = OWAMP_DEFS;
"nodes" = {
    foreach (name; desc; merge(PERFSONAR_TEST_HOSTS, PERFSONAR_VSC_TEST_HOSTS)) {
    fqdn = format("%s.%s", name, desc["domain"]);
    SELF[fqdn] = dict("longname", desc["desc"],
               "contact_addr", desc["ip"]["VSC"],
               "test_addr", desc["ip"]);

    };
    SELF;
};

"localnodes" = list(FULL_HOSTNAME);

"hosts" = {
    foreach (name; desc; value("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/nodes")) {
       SELF[name]["node"] = name;
    };
    SELF;
};

"groups" = {

    l = dict("description", "Group for UGent HPC 'representative' nodes",
        "type", "MESH");
    l["nodes"] = list();
    foreach (name; desc; value("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/nodes")) {
        if (match(name, '\.os$')) {
            l["nodes"]=append(l["nodes"], name);
        }
    };
    l["senders"] = l["nodes"];
    l["receivers"] = l["nodes"];
    SELF['ugent'] = l;
    if (PERFSONAR_BUOY_COLLECTOR) {
    l = dict("description", "Group for VSC 'representative' nodes",
          "type", "STAR");
    l["nodes"] = list();
    foreach (name; desc; value("/software/components/metaconfig/services/{/opt/perfsonar_ps/perfsonarbuoy_ma/etc/owmesh.conf}/contents/nodes")) {
        if (name == FULL_HOSTNAME || !match(name, '\.os$')) {
            l["nodes"]=append(l["nodes"], name);
        }
    };
    l["senders"] = l["nodes"];
    l["receivers"] = l["nodes"];
    l["hauptnode"] = FULL_HOSTNAME;
        SELF['vsc'] = l;
    };
    SELF;
};

"testspecs/BWTCP_4HR" = dict(
    "description", "4 Hour TCP Throughput (iperf)",
    "tool", "bwctl/iperf",
    "bw", dict("interval", 120,
    "start_alpha", 30,
    "duration", 25,
    "report_interval", 2));

"testspecs/LAT_1MIN" = dict(
    "description", "One-way latency",
    "tool", "powstream",
    "owamp", dict());

"measurementsets/test_bwtcp4_vsc_ugent" = dict(
    "description", "Mesh testing - 4-hour TCP throughput (iperf) - VSC interface",
    "addr_type", "VSC",
    "group", "ugent",
    "testspec", "BWTCP_4HR",
);

"measurementsets/test_lat4_vsc_ugent" = dict(
    "description", "Mesh testing - 1-minute latency - VSC interface",
    "addr_type", "VSC",
    "group", "ugent",
    "testspec", "LAT_1MIN",
);

"measurementsets/test_bwtcp4_vsc_outside" = if (PERFSONAR_BUOY_COLLECTOR) {
    dict(
        "description", "Star testing to VSC - 4-hour TCP throughput (iperf)",
        "addr_type", "VSC",
        "group", "vsc",
        "testspec", "BWTCP_4HR",
    );
} else {
    null;
};

"measurementsets/test_lat4_vsc_outside" = if (PERFSONAR_BUOY_COLLECTOR) {
    dict(
        "description", "Star testing to VSC - 1-minute latency",
        "addr_type", "VSC",
        "group", "vsc",
        "testspec", "LAT_1MIN",
    );
} else {
    null;
};
