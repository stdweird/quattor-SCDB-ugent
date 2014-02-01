unique template common/elasticsearch/hq/httpd;

prefix "/tmp/httpd/vhosts/base";

"directories" = append(nlist(
    "name", "/usr/share/elastichq",
    "options" , list("-Multiviews",),
    "access", nlist("allow", list("all")),
));

# remap the whole ES interface via /es
"locations" = append(nlist(
    "regex", true,
    "name", "^/es/(_nodes|_aliases|_search|.*/_search|_mapping|.*/_mapping|_aliases|_cache|_cluster|_flush|_mapping|_nodes|_optimize|_refresh|_search|_segments|_settings|_shutdown|_stats|_status|_cache/.*|_cluster/.*|_nodes/.*|)$",
    "proxy" , nlist(
        "pass", list(nlist(
            "match", true,
            "url", format("http://%s:9200/$1",ES_HTTP_IP))),
        "passreverse", list(nlist(
            "url", format("http://%s:9200/$1",ES_HTTP_IP))),
        ),
    ));

"aliases" = append(nlist(
    "url", "/hq", 
    "destination", "/usr/share/elastichq"
));
