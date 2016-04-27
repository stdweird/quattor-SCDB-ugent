unique template common/bacula/fd;

prefix "/software/packages";
"{ugbaculaclient}" = dict();

include 'components/chkconfig/config';
prefix "/software/components/chkconfig/service";
"bacula-fd" = dict(
    "startstop", true,
    "on", "");

include 'metaconfig/bacula/fd';

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/Director/0";
"Name" = format("%s-dir", BACULA_DIRECTOR_SHORT);
"Password" = BACULA_DIRECTOR_PASSWORD;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/Director/1";
"Name" = format("%s-mon", BACULA_DIRECTOR_SHORT);
"Password" = BACULA_DIRECTOR_PASSWORD;
"Monitor" = true;

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/Messages/0";
"Name" = "standard";
"messagedestinations" = list(
        dict("destination", "director",
              "address", format("%s-dir", BACULA_DIRECTOR_SHORT),
              "types", list("all", "!skipped", "!restored")),
        );

prefix "/software/components/metaconfig/services/{/etc/bacula/bacula-fd.conf}/contents/main/FileDaemon/0";
"Name" = format("%s-fd", FULL_HOSTNAME);
"Maximum_Network_Buffer_Size" = 256*1024;
