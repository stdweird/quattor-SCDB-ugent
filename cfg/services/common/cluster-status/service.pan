unique template common/cluster-status/service;
include 'common/cluster-status/rpms/config';
# add cluster_status.conf
include 'metaconfig/httpd/schema';
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}";
"module" = "httpd/generic_server";
"daemons" = dict("httpd", "restart");

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}/contents";
"aliases" = list(
    dict(
        "url", "/cluster_status",
        "destination", "/var/www/cluster_status",
        )
);
"directories" = list(
    dict(
        "name", "/var/www/cluster_status",
        "access", dict(
            "allowoverride", list("None")),
        ),
);
