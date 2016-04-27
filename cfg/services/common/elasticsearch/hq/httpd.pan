unique template common/elasticsearch/hq/httpd;

prefix "/tmp/httpd/vhosts/base";

"directories" = append(dict(
    "name", "/usr/share/elastichq",
    "options" , list("-Multiviews",),
    "access", dict("allow", list("all")),
));

# remap the whole ES interface via /es
"locations" = append(dict(
    "regex", true,
    "name", "^/es/(_nodes|_aliases|_search|.*/_search|_mapping|.*/_mapping|_aliases|_cache|_cluster|_flush|_mapping|_nodes|_optimize|_refresh|_search|_segments|_settings|_shutdown|_stats|_status|_cache/.*|_cluster/.*|_nodes/.*|)$",
    "proxy" , dict(
        "pass", list(dict(
            "match", true,
            "url", format("http://%s:9200/$1",ES_HTTP_IP))),
        "passreverse", list(dict(
            "url", format("http://%s:9200/$1",ES_HTTP_IP))),
        ),
    ));

"aliases" = append(dict(
    "url", "/hq", 
    "destination", "/usr/share/elastichq"
));
