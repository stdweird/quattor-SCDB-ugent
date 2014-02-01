unique template common/gpfs/logstash;

include {'common/logstash/service'};

prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(nlist("file", nlist(
    "path", list("/var/adm/ras/mmfs.log.latest"),
    "type", "gpfs",
    "tags", list("gpfs","storage"),
)));

"filter/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'gpfs'",
        )),
    "plugins", list(
        nlist("grok", nlist(
            "match", list(nlist(
                "name", "message", 
                "pattern", "%{GPFSLOG}"
                )),
            "patterns_dir", list("/usr/share/grok"),
            "add_field", nlist("program", "gpfs"),
            )),
        nlist("date", nlist(
            "match", nlist(
                "name", "timestamp", 
                "pattern", list("E MMM dd HH:mm:ss.SSS yyyy", "E MMM  d HH:mm:ss.SSS yyyy"),
                ),
            )),
        ),
));
