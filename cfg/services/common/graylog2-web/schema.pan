declaration template common/graylog2-web/schema;

@{
    Configuration of e-mail notifications sent by the Graylog2 web
    interface.
};
type g2_mail_environment = {
  "via" : string = "smtp"
  "host" : type_fqdn
  "enable_starttls_auto" : boolean
  "port" : type_port
  "auth" ? string with match(SELF, "^(plain|login|cram_md5)$")
  "user" ? string
  "password" ? string
  "domain" : type_fqdn
};

bind "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/email.yml}/contents" = g2_mail_environment{};

@{
    General index configuration
};
type g2_indexer_general = {
    "external_hostname" : type_fqdn
    "date_format" : string = "%d-%m-%YT%H:%M:%S"
    "allow_deleting" ? boolean
    "allow_version_check" ? boolean
    "custom_cookie_name" ? string
};

type g2_notifications = {
    "from" : type_email
    "subject" : string
};

type g2_hoptoad = {
  "enabled" : boolean
  "ssl" ? boolean
  "api_key" ? string
};

type g2_general = {
    "general" : g2_indexer_general
    "subscriptions" ? g2_notifications
    "streamalarms" ? g2_notifications
    "hoptoad" ? g2_hoptoad
};

bind "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/general.yml}/contents" = g2_general;


type g2_indexer = {
    "index_name" : string = "graylog2"
    "url" : type_absoluteURI = "http://localhost:9200"
};

bind "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/indexer.yml}/contents" = g2_indexer;

type g2_mongo = {
    "host" : string
    "port" : type_port
    "username" ? string
    "password" ? string
    "database" : string
};

bind "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/mongoid.yml}/contents" = g2_mongo{};
