unique template common/bacula/sd;


prefix "/software/packages";
"{bacula-storage}" = nlist();

include {'components/chkconfig/config'};
prefix "/software/components/chkconfig/service";
"bacula-sd" = nlist(
    "startstop", true,
    "on", "");


bind "/software/components/metaconfig/services/{/etc/bacula/bacula-sd.conf}/contents" = bacula_config;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-sd.conf}";
"daemon/0" = "bacula-sd";
"module" = "bacula/main";
"mode" = 0640;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-sd.conf}/contents";

