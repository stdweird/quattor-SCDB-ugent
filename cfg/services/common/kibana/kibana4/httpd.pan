unique template common/kibana/kibana4/httpd;

# rewrite http on port 80
prefix "/tmp/httpd/vhosts/rewritehttp";
"ip/0" = DB_IP[HOSTNAME];
"port" = 80;
"servername" = FULL_HOSTNAME;
"rewrite/engine" = true;
"rewrite/rules/0/destination" = "https://%{HTTP_HOST}%{REQUEST_URI}"; 
"rewrite/rules/0/regexp" = "(.*)";
"rewrite/rules/0/conditions/0" = dict(
    "test", '%{HTTPS}',
    "pattern", "off",
);

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
        "proxy" , dict(
            "pass", list(dict(
                "url", "http://localhost:5601/",
                )),
            "passreverse", list(dict(
                "url", "http://localhost:5601/",
                )),
            ),
        ));
};
