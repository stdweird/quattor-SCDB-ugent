@{
Drop too old indexes from Elasticsearch and close moderately-old indexes.
}

unique template common/logging/drop-old;

final variable ELASTICSEARCH_MAX_INDEXES ?= 180;
final variable ELASTICSEARCH_OPEN_INDEXES ?= 90;

include 'components/cron/config';

"/software/components/cron/entries" = {
    append(
        dict("command",
              format('/usr/bin/curl -XDELETE %s:9200/logstash-$(date +\%%Y.\%%m.\%%d -d "%d days ago")',
                     ES_HTTP_IP, ELASTICSEARCH_MAX_INDEXES),
              "comment", "Drop old Elasticsearch indexes",
              "name", "elasticsearch-drop",
              "user", "elasticsearch",
              "group", "elasticsearch",
              "timing", dict("hour", "7",
                              "minute", "32")));
    append(
        dict("command",
              format('/usr/bin/curl -XPOST %s:9200/logstash-$(date +\%%Y.\%%m.\%%d -d "%d days ago")/_close',
                     ES_HTTP_IP, ELASTICSEARCH_OPEN_INDEXES),
              "comment", "Close not-so-old Elasticsearch indexes",
              "name", "elasticsearch-close",
              "user", "elasticsearch",
              "group", "elasticsearch",
              "timing", dict("hour", "7",
                              "minute", "20")));
};
