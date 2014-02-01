declaration template common/manage/schema;

type raw_configs_section = {
    "immpasswd" : string
    "dracpasswd" : string
    "cbmcpasswd" : string
    "bladepasswd" : string
    "bladeuser" : string
    "icinga_socket" : string
};

type manage_file = {
    "raw_configs" : raw_configs_section
};

bind "/software/components/metaconfig/services/{/etc/manage.cfg}/contents" = manage_file;
