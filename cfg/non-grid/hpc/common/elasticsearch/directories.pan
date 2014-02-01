unique template common/elasticsearch/directories;

include 'components/dirperm/config';

"/software/components/dirperm/paths" = {
    append(nlist(
        "path", "/srv/elasticsearch",
        "owner", "elasticsearch:elasticsearch",
        "type", "d",
        "perm", "0700"));
    append(nlist(
        "path", "/tmp/elasticsearch",
        "owner", "elasticsearch:elasticsearch",
        "type", "d",
        "perm", "0700"));
};
