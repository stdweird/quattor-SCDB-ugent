unique template common/graylog2-web/config;

include {'common/graylog2-web/schema'};

include 'common/graylog2-web/packages';

final variable GRAYLOG_WEB_PUBLIC ="/opt/graylog2-web-interface/public";

prefix "/software/components/accounts/users";

prefix "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/email.yml}";

"module" = "yaml";
"contents/production/via" = "smtp";
"contents/production/host" = "smtp.ugent.be";
"contents/production/enable_starttls_auto" = true;
"contents/production/port" = 25;
"contents/production/domain" = "ugent.be";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/general.yml}";

"module" = "yaml";
"contents/general/external_hostname" = OBJECT;
"contents/hoptoad/enabled" = false;
"contents/subscriptions/from" = "graylog2@tangela.ugent.be";
"contents/subscriptions/subject" = "[graylog2] Subscription";
"contents/streamalarms/from" = "graylog2@tangela.ugent.be";
"contents/streamalarms/subject" = "[graylog2] Stream alarm";
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/mongoid.yml}";

"module" = "yaml";
"contents/production/host" = "localhost";
"contents/production/database" = "graylog2";
"contents/production/port" = 27017;
"daemon/0" = "httpd";

prefix "/software/components/metaconfig/services/{/opt/graylog2-web-interface/config/indexer.yml}";

"module" = "yaml";
"contents" = nlist();
"daemon/0" = "httpd";

# configure passenger
include {'common/passenger/service'};

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/rails.conf}/contents/vhosts/passenger";

"servername" = FULL_HOSTNAME;
"documentroot" = GRAYLOG_WEB_PUBLIC;
"rails/env" = "production";
"directories" = append(nlist(
    "name", GRAYLOG_WEB_PUBLIC,
    "ssl", nlist("requiressl", true),
    "options", list("-Multiviews", "-Indexes"),
));
