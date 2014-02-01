declaration template common/oncall/schema;

type oncall_db = {
    "name" : string
    "user" : string
    "password" : string
};

type oncall_google = {
    "login" : type_email
    "passwd" : string
};

type oncall_sms = {
    "passwd" : string
};

type oncall_mail = {
    "from" : type_email
    "to" : type_email
};

type oncall_admin_list = {
    "shortn" : string
};

type oncall_admin = {
    "name" : string
    "email" : type_email
    "tel" : string
};

type oncall_file = extensible {
    "db" : oncall_db
    "google" : oncall_google
    "sms" : oncall_sms
    "mail" : oncall_mail
    "admins" : oncall_admin_list
};

bind "/software/components/metaconfig/services/{/etc/oncall.conf}/contents" = oncall_file;
