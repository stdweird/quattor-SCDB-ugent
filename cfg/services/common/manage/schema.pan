declaration template common/manage/schema;

type raw_configs_section = {
    "IMMPASSWD" : string
    "DRACPASSWD" : string
    "CBMCPASSWD" : string
    "BLADEPASSWD" : string
    "BLADEUSER" : string
    "IMM_USER_GASTLY": string
    "IMM_USER_HAUNTER": string
    "IMM_USER_GULPIN": string
    "IMM_USER_DUGTRIO": string
    "IMM_USER_RAICHU": string
    "IMM_USER_DELCATTY": string
    "IMM_USER_PHANPY": string
    "IMM_USER_GOLETT": string
    "ICINGA_SOCKET" : string
};

type manage_file = {
    "raw_configs" : raw_configs_section
};

bind "/software/components/metaconfig/services/{/etc/manage.cfg}/contents" = manage_file;
