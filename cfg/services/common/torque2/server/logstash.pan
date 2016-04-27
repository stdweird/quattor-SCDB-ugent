unique template common/torque2/server/logstash;
include 'common/logstash/service';
prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("file", dict(
    "path", list("/var/spool/pbs/server_logs/*"),
    "exclude", list("*.gz"),
    "type", "pbs",
    "tags", list("batch", "torque")
)));

"filter/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'pbs'",
        )),
    "plugins", list(
        dict("grok", dict(
            "match", list(dict(
                "name", "message", 
                "pattern", list("%{PBS_LOG}"),
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", dict("program", "pbs_server"),
            )),
        dict("drop", dict("_conditional", dict("expr", list(dict(
            "left", "[txt]",
            "test", "!~",
            "right", "'^IS_STATUS'",
            ))))),
        dict("date", dict(
            "match", dict(
                "name", "timestamp", 
                "pattern", list("MM/dd/YYYY HHHH:mm:ss"),
                ),
            )),
        ),
));
