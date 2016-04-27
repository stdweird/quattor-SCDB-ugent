unique template common/moab/server/logstash;
include 'common/logstash/service';
prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("file", dict(
    "path", list("/var/spool/moab/log/moab.log"),
    "type", "moab", 
    "tags", list("batch", "torque")
)));


"filter/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'moab'",
        )),
    "plugins", list(
        # drop some irrelevant data
        dict("drop", dict("_conditional", dict("expr", list(dict(
            "left", "[@message]",
            "test", "=~",
            "right", '"^\d+\/\d+\s+\d+:\d+:\d+"', # escaped / is required give logstash crappy regex converter
            ))))),
        dict("grok", dict(
            "match", list(dict(
                "name", "message", 
                "pattern", list("%{MOABLOG}"),
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", dict("program", "moab"),
            )),
        dict("drop", dict("_conditional", dict("expr", list(dict(
            "left", "[funcname]",
            "test", "!~",
            "right", "'^M'",
            ))))),
        dict("date", dict(
            "match", dict(
                "name", "timestamp", 
                "pattern", list("MM/dd HH:mm:ss"),
                ),
            )),
        ),
));
