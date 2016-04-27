unique template common/pbsmon2php/service;
include 'common/pbsmon2php/config';
include 'components/cron/config';
"/software/components/cron/entries" =
    append(dict("command", "/usr/bin/generatemotd.sh",
        "comment", "Generate the motd for the cluster stat and write it in different formats to a public dir",
        "name", "generate-cluster-motd",
        "timing", dict("minute", "*/5")
        )
);

include 'common/pbsmon2php/packages';

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents/vhosts/base";
"documentroot" = "/var/www/html";
