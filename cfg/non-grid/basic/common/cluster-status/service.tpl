unique template common/cluster-status/service;

include { 'common/cluster-status/rpms/config'+RPM_BASE_FLAVOUR };

# add cluster_status.conf
include 'common/httpd/schema';
bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}";
"module" = "httpd/generic_server";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/cluster_status.conf}/contents";
"aliases" = list(
    nlist(
        "url", "/cluster_status",
        "destination", "/var/www/cluster_status",
        )
);
"directories" = list(
    nlist(
        "name", "/var/www/cluster_status",
        "access", nlist(
            "allowoverride", list("None")),
        ),
);

