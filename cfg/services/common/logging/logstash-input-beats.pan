unique template common/logging/logstash-input-beats;

include 'common/logstash/service';

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("beats", dict(
    "type", "beats", # will not forcefully overwrite, only used when missing
    "port", 5043,
    "ssl", true,
    "ssl_certificate", value("/software/components/ccm/cert_file"),
    "ssl_key", value("/software/components/ccm/key_file"),
)));
