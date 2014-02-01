unique template common/nat/logstash;

include {'components/dirperm/config'};
include {'common/logstash/service'};

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(nlist("gelf", nlist(
    # type is/can be set in output gelf filter. 
    # this will not forcefully overwrtie in 1.2.2
    "type", "remotegelf",
    "port", 12201,
)));

"filter/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'remotegelf'",
        )),
    "plugins", list(nlist("mutate", nlist(
        "split", nlist("tags", ", "),
    ))),
));

"output/plugins" = null; # remove the default
"output/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'httpd'",
        )),
    "plugins", list(nlist("gelf", nlist(
        "port", 12201,
        "sender", HOSTNAME,
        "ship_metadata", true,
        "host", SYSLOG_RELAY,
        "custom_fields", nlist("type", "remotegelf"),
        "level", list("info"),
        ))),
));

"output/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'remotegelf'",
        )),
    "plugins", list(nlist("gelf", nlist(
        "port", 12201,
        "ship_metadata", true,
        "host", SYSLOG_RELAY,
        "custom_fields", nlist("type", "remotegelf"),
        "level", list("%{level}"),
        "facility", "%{facility}",
        ))),
));
