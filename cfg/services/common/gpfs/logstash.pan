unique template common/gpfs/logstash;

include 'common/logstash/service';

prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("file", dict(
    "path", list("/var/adm/ras/mmfs.log.latest"),
    "type", "gpfs",
    "tags", list("gpfs","storage"),
)));

include 'common/logging/logstash-gpfs'; # the gpfs filter
