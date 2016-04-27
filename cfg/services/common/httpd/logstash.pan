unique template common/httpd/logstash;
include 'components/dirperm/config';
include 'common/logstash/service';
prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("file", dict(
    "path", list("/var/log/httpd/access_log"),
    "type", "httpd",
	"tags", list("httpd", "apache", "web", "http")
)));

"filter/conditionals" = append(dict(
    "type", "ifelseif",
    "expr", list(dict(
        "left", "[type]",
        "test", "==",
        "right", "'httpd'",
        )),
    "plugins", list(
        dict("grok", dict(
            "add_field", dict("program", "httpd"),
            "patterns_dir", list("/usr/share/grok"),
            "match", list(dict(
                "name", "message",
                "pattern", list("%{COMBINEDAPACHELOG}"),
                ))
            )),
        dict("date", dict(
            "match", dict(
                "name", "timestamp", 
                "pattern", list("dd/MMM/yyyy:HH:mm:ss Z"),
                ),
            )),
        ),
));       

prefix "/software/components/dirperm";
"paths" = append(dict(
    "path", "/var/log/httpd",
    "owner", "root:logstash",
    "perm", "0750",
    "type", "d"
));
