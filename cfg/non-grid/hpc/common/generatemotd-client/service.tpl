unique template common/generatemotd-client/service;

variable GENERATEMOTD_CLIENT_URL ?= 'https://mewtwo.ugent.be/ansi.txt';

include {'components/cron/config'};
"/software/components/cron/entries" =
    append(nlist("command", "wget --no-check-certificate --output-document /etc/motd "+GENERATEMOTD_CLIENT_URL,
        "comment", "Fetch the motd for the cluster stat and write to motd",
        "name", "fetch-cluster-motd",
        "timing", nlist("minute", "*/5")
        )
);
