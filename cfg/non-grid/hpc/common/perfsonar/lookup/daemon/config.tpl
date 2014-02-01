unique template common/perfsonar/lookup/daemon/config;

include {'common/perfsonar/lookup/daemon/schema'};

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/lookup_service/etc/daemon.conf}";

"module" = "perfsonar/lookup_service";
"owner" = "root";
"group" = "root";
"daemon/0" = "lookup_service";
"backup" = ".old";
