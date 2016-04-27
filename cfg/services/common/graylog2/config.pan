unique template common/graylog2/config;

prefix "/software/components/accounts";

"users/graylog2" = dict("comment", "Graylog2 account",
    "homeDir", "/var/lib/graylog2",
    "shell", "/sbin/nologin",
    "password", "!",
    "uid", 3001,
    "groups", list("graylog2")
);

"groups/graylog2/gid" = 3001;

include 'metaconfig/graylog2/config';
