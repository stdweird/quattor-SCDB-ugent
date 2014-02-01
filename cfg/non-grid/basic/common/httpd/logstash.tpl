unique template common/httpd/logstash;

include {'components/dirperm/config'};
include {'common/logstash/service'};

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(nlist("file", nlist(
    "path", list("/var/log/httpd/access_log"),
    "type", "httpd",
	"tags", list("httpd", "apache", "web", "http")
)));

"filter/conditionals" = append(nlist(
    "type", "ifelseif",
    "expr", list(nlist(
        "left", "[type]",
        "test", "==",
        "right", "'httpd'",
        )),
    "plugins", list(
        nlist("grok", nlist(
            "add_field", nlist("program", "httpd"),
            "patterns_dir", list("/usr/share/grok"),
            "match", list(nlist(
                "name", "message",
                "pattern", "%{COMBINEDAPACHELOG}"
                ))
            )),
        nlist("date", nlist(
            "match", nlist(
                "name", "timestamp", 
                "pattern", list("dd/MMM/yyyy:HH:mm:ss Z"),
                ),
            )),
        ),
));       

prefix "/software/components/dirperm";
"paths" = append(nlist(
    "path", "/var/log/httpd",
    "owner", "root:logstash",
    "perm", "0750",
    "type", "d"
));
