unique template common/logging/logstash-input-gelf;

include 'common/logstash/service';

prefix  "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}/contents";

"input/plugins" = append(dict("gelf", dict(
    # type is/can be set in output gelf filter. 
    # this will not forcefully overwrite
    "type", "remotegelf",
    "port", 12201,
)));
