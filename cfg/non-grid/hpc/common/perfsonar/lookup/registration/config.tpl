unique template common/perfsonar/lookup/registration/config;

include {'common/perfsonar/lookup/registration/schema'};

prefix "/software/components/metaconfig/services/{/opt/perfsonar_ps/ls_registration_daemon/etc/ls_registration_daemon.conf}";

"module" = "general";
"owner" = "root";
"group" = "root";
"daemon/0" = "ls_registration_daemon";
