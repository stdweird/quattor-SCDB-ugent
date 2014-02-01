unique template common/bacula/director_part;


bind "/software/components/metaconfig/services/{/etc/bacula/director-part.conf}/contents" = bacula_config;

prefix "/software/components/metaconfig/services/{/etc/bacula/director-part.conf}";
"daemon/0" = "bacula-sd";
"module" = "bacula/main";
"mode" = 0640;

prefix "/software/components/metaconfig/services/{/etc/bacula/director-part.conf}/contents/main/Director/0";
"Name" = format("%s-dir", BACULA_DIRECTOR_SHORT);
"Password" = '@/etc/bacula/pw';
"Monitor" = true;

prefix "/software/components/metaconfig/services/{/etc/bacula/director-part.conf}/contents/main/Messages/0";
"Name" = "standard";
"messagedestinations" = list(
        nlist("destination", "director",
              "address", format("%s-dir",BACULA_DIRECTOR_SHORT),
              "types", list("all", "!skipped", "!restored")),
        );
