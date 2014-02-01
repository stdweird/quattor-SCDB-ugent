unique template common/bacula/fd;

prefix "/software/packages";
"{bacula-client}" = nlist();

include {'components/chkconfig/config'};
prefix "/software/components/chkconfig/service";
"bacula-fd" = nlist(
    "startstop", true,
    "on", "");

bind "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents" = bacula_config;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}";
"daemon/0" = "bacula-fd";
"module" = "bacula/main";
"mode" = 0640;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/Director/0";
"Name" = format("%s-dir", BACULA_DIRECTOR_SHORT);
"Password" = '@/etc/bacula/pw';
"Monitor" = true;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/Messages/0";
"Name" = "standard";
"messagedestinations" = list(
        nlist("destination", "director",
              "address", format("%s-dir", BACULA_DIRECTOR_SHORT),
              "types", list("all", "!skipped", "!restored")),
        );

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/FileDaemon/0";
"Name" = format("%s-fd", FULL_HOSTNAME);
"Maximum_Network_Buffer_Size" = 256*1024;
