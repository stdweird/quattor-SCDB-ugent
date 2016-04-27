unique template common/beats/logstash;

prefix "/software/components/metaconfig/services/{/etc/filebeat/filebeat.yml}/contents/output/logstash";
"hosts" = append(format("%s:%s", SYSLOG_RELAY, 5043));

"tls/certificate" = value("/software/components/ccm/cert_file");
"tls/certificate_key" = value("/software/components/ccm/key_file");
"tls/certificate_authorities" = append(value("/software/components/ccm/ca_file"));
