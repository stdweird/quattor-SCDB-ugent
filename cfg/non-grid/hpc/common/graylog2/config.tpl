unique template common/graylog2/config;

prefix "/software/components/accounts";

"users/graylog2" = nlist("comment", "Graylog2 account",
    "homeDir", "/var/lib/graylog2",
    "shell", "/sbin/nologin",
    "password", "!",
    "uid", 3001,
    "groups", list("graylog2")
);

"groups/graylog2/gid" = 3001;

prefix "/software/components/metaconfig/services/{/etc/graylog2.conf}";

"module" = "graylog/server";

"contents/syslog_listen_port" = 5678;
"contents/rules_file" = "/etc/graylog2/graylog2.drl";
"contents/amqp_enabled" = false;
"contents/syslog_protocol" = "tcp";
