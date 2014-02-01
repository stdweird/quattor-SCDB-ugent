unique template common/manage/config;

include 'common/manage/schema';

prefix "/software/components/metaconfig/services/{/etc/manage.cfg}/contents";

"raw_configs/immpasswd" = IPMI_PASSWD;
"raw_configs/dracpasswd" = IPMI_PASSWD;
"raw_configs/cbmcpasswd" = IPMI_PASSWD;
"raw_configs/bladepasswd" = IPMI_PASSWD;
"raw_configs/bladeuser" = "USERID";
"raw_configs/icinga_socket" = "/var/spool/icinga/cmd/icinga.cmd";

prefix "/software/components/metaconfig/services/{/etc/manage.cfg}";

"module" = "tiny";
"group" = "wheel";
"mode" = 0640;
