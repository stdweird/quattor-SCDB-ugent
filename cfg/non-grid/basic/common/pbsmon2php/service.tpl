unique template common/pbsmon2php/service;

include { 'common/pbsmon2php/config' };
include {'components/cron/config'};

"/software/components/cron/entries" =
    append(nlist("command", "/usr/bin/generatemotd.sh",
        "comment", "Generate the motd for the cluster stat and write it in different formats to a public dir",
        "name", "generate-cluster-motd",
        "timing", nlist("minute", "*/5")
        )
);

include 'common/pbsmon2php/packages';
