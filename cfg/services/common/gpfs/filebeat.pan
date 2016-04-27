unique template common/gpfs/filebeat;

include 'common/beats/filebeat';

"/software/components/metaconfig/services/{/etc/filebeat/filebeat.yml}/contents/filebeat/prospectors" = append(dict(
    "paths", list("/var/adm/ras/mmfs.log.latest"),
    "fields", dict("type", "gpfs"),
));
