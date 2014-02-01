unique template common/kibana/httpd;

# rewrite http on port 80
prefix "/tmp/httpd/vhosts/rewritehttp";
"ip/0" = DB_IP[HOSTNAME];
"port" = 80;
"servername" = FULL_HOSTNAME;
"rewrite/engine" = true;
"rewrite/rules/0/destination" = "https://%{HTTP_HOST}%{REQUEST_URI}"; 
"rewrite/rules/0/regexp" = "(.*)";
"rewrite/rules/0/conditions/0" = nlist(
    "test", '%{HTTPS}',
    "pattern", "off",
);

prefix "/tmp/httpd/vhosts/base";

# add actual/real cert/key?

"documentroot" = "/usr/share/kibana";
"directories" = append(nlist(
    "name", "/usr/share/kibana",
    "options" , list("-Multiviews",),
    "access", nlist("allow", list("all")),
));
"log/level" = "info";
"log/error" = "logs/kibana_error_log";
"log/custom" = list(nlist(
    "location", "logs/kibana_access_log", 
    "name", "combined"
));

"locations" = {
    append(nlist(
        "regex", true,
        "name", "^/(_nodes|_aliases|_search|.*/_search|_mapping|.*/_mapping)$",
        "proxy" , nlist(
            "pass", list(nlist(
                "match", true,
                "url", format("http://%s:9200/$1",ES_HTTP_IP))),
            "passreverse", list(nlist(
                "url", format("http://%s:9200/$1",ES_HTTP_IP))),
            ),
        ));
    append(nlist(
        "regex", true,
        "name", "^/(kibana-int/dashboard/|kibana-int/temp)(.*)$",
        "proxy" , nlist(
            "pass", list(nlist(
                "match", true,
                "url", format("http://%s:9200/$1$2",ES_HTTP_IP))),
            "passreverse", list(nlist(
                "url", format("http://%s:9200/$1$2",ES_HTTP_IP))),
            ),
        ));
    append(nlist(
        "name", "/",
        "access", nlist( # by default, block all
            "deny", list("all"),
            "satisfy", "Any",
            "order", list("allow", "deny"),
            ),
        "limit", nlist( # do not allow PUT and DELETE of ES data via kibana interface
            "name", list("PUT", "DELETE"),
            "access", nlist(
                "order", list("allow", "deny"),
                "deny", list("all"),
                ),
            ),
        ));
};

"proxies" = append(nlist(
    "name", format("http://%s:9200",ES_HTTP_IP),
    "proxy", nlist(
        "set", nlist(
            "data", nlist(
                "connectiontimeout", "5",
                "timeout", "90",
                ),
            ),
        ),
));
