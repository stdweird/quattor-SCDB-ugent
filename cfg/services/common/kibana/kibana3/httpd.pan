unique template common/kibana/kibana3/httpd;

# rewrite http on port 80
"/tmp/httpd/vhosts/rewritehttp" = create('common/httpd/struct/https_rewrite');

prefix "/tmp/httpd/vhosts/base";

# add actual/real cert/key?

"documentroot" = "/usr/share/kibana";
"directories" = append(dict(
    "name", "/usr/share/kibana",
    "options" , list("-Multiviews",),
    "access", dict("allow", list("all")),
));
"log/level" = "info";
"log/error" = "logs/kibana_error_log";
"log/custom" = list(dict(
    "location", "logs/kibana_access_log",
    "name", "combined"
));

"locations" = {
    append(dict(
        "regex", true,
        "name", "^/(_nodes|_aliases|_search|.*/_search|_mapping|.*/_mapping|logstash-[0-9][0-9][0-9][0-9]\\.[0-9][0-9]\\.[0-9][0-9].*)$",
        "proxy" , dict(
            "pass", list(dict(
                "match", true,
                "url", format("http://%s:9200/$1",ES_HTTP_IP))),
            "passreverse", list(dict(
                "url", format("http://%s:9200/$1",ES_HTTP_IP))),
            ),
        ));
    append(dict(
        "regex", true,
        "name", "^/(kibana-int/dashboard/|kibana-int/temp)(.*)$",
        "proxy" , dict(
            "pass", list(dict(
                "match", true,
                "url", format("http://%s:9200/$1$2",ES_HTTP_IP))),
            "passreverse", list(dict(
                "url", format("http://%s:9200/$1$2",ES_HTTP_IP))),
            ),
        ));
    append(dict(
        "name", "/",
        "access", dict( # by default, block all
            "deny", list("all"),
            "satisfy", "Any",
            "order", list("allow", "deny"),
            ),
        "limit", dict( # do not allow PUT and DELETE of ES data via kibana interface
            "name", list("PUT", "DELETE"),
            "access", dict(
                "order", list("allow", "deny"),
                "deny", list("all"),
                ),
            ),
        ));
};

"proxies" = append(dict(
    "name", format("http://%s:9200",ES_HTTP_IP),
    "proxy", dict(
        "set", dict(
            "data", dict(
                "connectiontimeout", "5",
                "timeout", "90",
                ),
            ),
        ),
));
