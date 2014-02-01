unique template common/torque2/server/logstash;

include {'common/logstash/service'};

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(nlist("file", nlist(
    "path", list("/var/spool/pbs/server_logs/*"),
    "exclude", list("*.gz"),
    "type", "pbs",
    "tags", list("batch", "torque")
)));

"filter/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'pbs'",
        )),
    "plugins", list(
        nlist("grok", nlist(
            "match", list(nlist(
                "name", "message", 
                "pattern", "%{PBS_LOG}"
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", nlist("program", "pbs_server"),
            )),
        nlist("grep", nlist(
            "drop", true,
            "negate", true,
            "match", list(nlist(
                "name", "txt",
                "pattern", "^IS_STATUS",
                )),
            )),
        nlist("date", nlist(
            "match", nlist(
                "name", "timestamp", 
                "pattern", list("MM/dd/YYYY HHHH:mm:ss"),
                ),
            )),
        ),
));
			      