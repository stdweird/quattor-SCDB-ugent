@{ Instantiation of the BUOY-based Perfsonar configurations }

unique template common/perfsonar/monitoring/icinga;

include {if_exists('site/perfsonar')};

"/software/components/icinga/services" = {
    foreach (src; i; PERFSONAR_TEST_HOSTS) {
        sfqdn = format("%s.%s", src, i["domain"]);
        foreach (dst; j; PERFSONAR_TEST_HOSTS) {
    	    if (src != dst) {
                dfqdn = format("%s.%s", dst, j["domain"]);
                chk = create("monitoring/icinga/monitoring/services/system/network_throughput",
                             "check_command", list("check_nrpe_throughput", i["ip"]["VSC"], j["ip"]["VSC"],
						                           "900000", "750000"),
                             "host_name", list(sfqdn));

                k = escape(format("%s for %s", chk["service_description"], dst));
                chk["service_description"] = null;
                if (exists(SELF[k])) {
                    SELF[k]=append(SELF[k], chk);
                } else {
                    SELF[k] = list(chk);
    		};
                chk = create("monitoring/icinga/monitoring/services/system/network_latency",
                             "check_command", list("check_nrpe_latency", i["ip"]["VSC"], j["ip"]["VSC"], "30", "60"),
                             "host_name", list(sfqdn));
                k = escape(format("%s for %s", chk["service_description"], dst));
                chk["service_description"] = null;
                if (exists(SELF[k])) {
                    SELF[k]=append(SELF[k], chk);
                } else {
                    SELF[k] = list(chk);
		};
    	    }
    	}
    };

    mgip = PERFSONAR_TEST_HOSTS['magikarp']['ip']['VSC'];
    mgfqdn = format("%s.%s", "magikarp", PERFSONAR_TEST_HOSTS['magikarp']['domain']);
    foreach (src; i; PERFSONAR_VSC_TEST_HOSTS) {
	sfqdn = format("%s.%s", src, i["domain"]);
	chk = create("monitoring/icinga/monitoring/services/system/network_throughput",
		     "check_command", list("check_nrpe_throughput", mgip, i["ip"]["VSC"]),
		                           "host_name", list(mgfqdn));
	k = escape(format("%s for %s", chk["service_description"], src));
	chk['service_description'] = null;
	if (exists(SELF[k])) {
	    SELF[k]=append(SELF[k], chk);
	} else {
	    SELF[k] = list(chk);
	};
	chk = create("monitoring/icinga/monitoring/services/system/network_latency",
		     "check_command", list("check_nrpe_latency", mgip, i["ip"]['VSC']),
                                   "host_name", list(mgfqdn));

	k = escape(format("%s for %s", chk["service_description"], src));
	chk['service_description'] = null;
	if (exists(SELF[k])) {
	    SELF[k]=append(SELF[k], chk);
	} else {
	    SELF[k] = list(chk);
	}
    };

    SELF;
};
