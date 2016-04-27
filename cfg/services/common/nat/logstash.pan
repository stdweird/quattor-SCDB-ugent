unique template common/nat/logstash;

variable GPFS_FILEBEAT ?= true;

include 'common/logstash/service';

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"filter/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'remotegelf'",
        )),
    "plugins", list(dict("mutate", dict(
        "split", dict("tags", ", "),
    ))),
));

"output/plugins" = null; # remove the default
"output/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'httpd'",
        )),
    "plugins", list(dict("gelf", dict(
        "port", 12201,
        "sender", HOSTNAME,
        "ship_metadata", true,
        "host", SYSLOG_RELAY,
        "custom_fields", dict("type", "remotegelf"),
        "level", list("info"),
        ))),
));

"output/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'remotegelf'",
        )),
    "plugins", list(dict("gelf", dict(
        "port", 12201,
        "ship_metadata", true,
        "host", SYSLOG_RELAY,
        "custom_fields", dict("type", "remotegelf"),
        "level", list("%{severity}", "INFO"),
        ))),
));

include 'common/logging/logstash-input-gelf';
include 'common/logging/logstash-input-beats';

include { if(GPFS_FILEBEAT) { 'common/logging/logstash-filter-gpfs' }};
