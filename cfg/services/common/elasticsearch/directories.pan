unique template common/elasticsearch/directories;

include 'components/dirperm/config';

"/software/components/dirperm/paths" = {
    owner_group_dir = list(
        '/var/lib/elasticsearch',
        '/tmp/elasticsearch',
        '/var/log/elasticsearch',
        '/var/run/elasticsearch',
        );
    foreach (idx;path;owner_group_dir) {
        append(dict(
            "path", path,
            "owner", "elasticsearch:elasticsearch",
            "type", "d",
            "perm", "0700"));
    };

    group_dir = list(
        "/etc/elasticsearch",
        "/etc/elasticsearch/scripts",
        );
    foreach (idx;path;group_dir) {
        append(dict(
            "path", path,
            "owner", "root:elasticsearch",
            "type", "d",
            "perm", "0750"));
    };

    group_file = list(
        "/etc/elasticsearch/logging.yml",
        );
    foreach (idx;path;group_file) {
        append(dict(
            "path", path,
            "owner", "root:elasticsearch",
            "type", "f",
            "perm", "0640"));
    };
    SELF;
};
