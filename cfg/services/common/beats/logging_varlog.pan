unique template common/beats/logging_varlog;

prefix "/software/components/metaconfig/services/{/etc/filebeat/filebeat.yml}/contents/logging";
"to_files" = true;
"to_syslog" = false;
"files/path" = "/var/log/beats";
"files/name" = "filebeat.log";
"files/keepfiles" =  3;
