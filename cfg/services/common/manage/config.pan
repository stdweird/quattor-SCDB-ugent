unique template common/manage/config;

include 'common/manage/schema';

prefix "/software/components/metaconfig/services/{/etc/manage.cfg}/contents";

"raw_configs/IMMPASSWD" = IPMI_PASSWD;
"raw_configs/DRACPASSWD" = IPMI_PASSWD;
"raw_configs/CBMCPASSWD" = IPMI_PASSWD;
"raw_configs/BLADEPASSWD" = IPMI_PASSWD;
"raw_configs/BLADEUSER" = "USERID";
"raw_configs/IMM_USER_GASTLY" = "USERID";
"raw_configs/IMM_USER_HAUNTER" = "USERID";
"raw_configs/IMM_USER_GULPIN" = "root";
"raw_configs/IMM_USER_DUGTRIO" = "root";
"raw_configs/IMM_USER_RAICHU" = "USERID";
"raw_configs/IMM_USER_DELCATTY" = "root";
"raw_configs/IMM_USER_PHANPY" = "admin";
"raw_configs/IMM_USER_GOLETT" = "admin";

"raw_configs/ICINGA_SOCKET" = "/var/spool/icinga/cmd/icinga.cmd";

prefix "/software/components/metaconfig/services/{/etc/manage.cfg}";

"module" = "tiny";
"group" = "wheel";
"mode" = 0640;
