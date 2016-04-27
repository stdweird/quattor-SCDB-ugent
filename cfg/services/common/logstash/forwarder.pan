unique template common/logstash/forwarder;

include 'components/chkconfig/config';
include 'components/metaconfig/config';

"/system/monitoring/hostgroups" = append("logstash-forwarder");

"/software/components/chkconfig/service/logstash-forwarder" = dict(
    "on", "",
    "startstop", true);

include 'metaconfig/logstash/forwarder';

prefix "/software/components/metaconfig/services/{/etc/logstash-forwarder.conf}/contents/network";
"servers" = append(dict("host",  SYSLOG_RELAY, "port", 5043));
"ssl_certificate" = value("/software/components/ccm/cert_file");
"ssl_key" = value("/software/components/ccm/key_file");
"ssl_ca" = value("/software/components/ccm/ca_file");

prefix "/software/packages";
"{logstash-forwarder}" = dict();

# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
include 'components/altlogrotate/config';

"/software/components/altlogrotate/entries/logstash-forwarder-stderr" =
  dict("pattern", "/var/log/logstash-forwarder/logstash-forwarder.stderr",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 5,
        "nomail", true);
"/software/components/altlogrotate/entries/logstash-forwarder-stdout" =
  dict("pattern", "/var/log/logstash-forwarder/logstash-forwarder.stdout",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 5,
        "nomail", true);
