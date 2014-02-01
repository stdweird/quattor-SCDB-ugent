unique template common/moab/server/logstash;

include {'common/logstash/service'};

prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(nlist("file", nlist(
    "path", list("/var/spool/moab/log/moab.log"),
    "type", "moab", 
    "tags", list("batch", "torque")
)));


"filter/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'moab'",
        )),
    "plugins", list(
        # grep negate first to filter out some irrelevant data
        nlist("grep", nlist(
            "drop", true,
            "match", list(nlist(
                "name", "@message", 
                "pattern", '^\d+/\d+\s+\d+:\d+:\d+',
                )),
            )),
        nlist("grok", nlist(
            "match", list(nlist(
                "name", "message", 
                "pattern", "%{MOABLOG}"
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", nlist("program", "moab"),
            )),
        nlist("grep", nlist(
            "match", list(nlist(
                "name", "funcname",
                "pattern", "M.*"
                )),
            "drop", true,
            "negate", true
            )),
        nlist("date", nlist(
            "match", nlist(
                "name", "timestamp", 
                "pattern", list("MM/dd HH:mm:ss"),
                ),
            )),
        ),
));
