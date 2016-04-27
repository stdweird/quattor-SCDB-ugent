unique template common/logging/logstash-filter-gpfs;

include 'common/logstash/service';

prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"filter/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'gpfs'",
        )),
    "plugins", list(
        dict("grok", dict(
            "match", list(dict(
                "name", "message", 
                "pattern", list("%{GPFSLOG}"),
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", dict("program", "gpfs"),
            )),
        dict("date", dict(
            "match", dict(
                "name", "timestamp", 
                "pattern", list("E MMM dd HH:mm:ss.SSS yyyy", "E MMM  d HH:mm:ss.SSS yyyy"),
                ),
            )),
        ),
));
