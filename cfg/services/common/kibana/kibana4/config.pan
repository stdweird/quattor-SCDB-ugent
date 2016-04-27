unique template common/kibana/kibana4/config;

include 'metaconfig/kibana/config';

# runs as kibana user
# user autoadded via rpms in 4.2, not anymore in 4.3
variable KIBANA_USER_IN_KIBANA_RPM ?= false;
include {
    if(KIBANA_USER_IN_KIBANA_RPM) {
        'common/kibana/kibana4/rpm_user';
    } else {
        'common/kibana/kibana4/user';
    };
};

# start daemon (requires 4.1+ rpms)
"/software/components/chkconfig/service/kibana" = dict("on", "", "startstop", true);

include 'common/kibana/kibana4/config_ssl';

# kibana adds some optimisation data in the rpm paths
"/software/components/dirperm/paths" = append(dict(
    "path", '/opt/kibana/optimize',
    "owner", "root:kibana",
    "type", "d",
    "perm", "0775",
    ));

# file has to exists before kibana will start
"/software/components/dirperm/paths" = append(dict(
    "path", '/opt/kibana/optimize/.babelcache.json',
    "owner", "kibana:root",
    "type", "f",
    "perm", "0770",
    ));
