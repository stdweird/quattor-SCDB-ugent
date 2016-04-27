unique template common/kibana/service;

variable KIBANA_VERSION ?= 4;

include { format('common/kibana/kibana%s/config', KIBANA_VERSION); };

include 'common/kibana/packages';

# default home dir of kibana user is /home/kibana, which needs to exist
variable KIBANA_HOME = "/home/kibana";

prefix "/software/components/dirperm";
"paths" = {
    foreach (i; path; list("/var/log/kibana", KIBANA_HOME)) {
        append(dict("owner", "kibana:kibana", "type", "d", "perm", "0750",
                     "path", path));
    };
};
