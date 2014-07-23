unique template site/monitoring/logs/aii/config;

prefix "/system/aii/osinstall/ks/logging";
"host" = SYSLOG_RELAY;
"port" = 515;
"level" = "debug";
"console" = false;
"send_aiilogs" = true;
