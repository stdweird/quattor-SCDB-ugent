unique template common/httpd/config/default;

# httpd.conf
include 'common/httpd/config/httpd_conf';

# changes that used to be part of filecopy config
prefix "/software/components/metaconfig/services/{/etc/httpd/conf/httpd.conf}/contents";
"listen" = {
    append(dict(
        "port", 80
        ));
};

"global/traceenable" = "off";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf/httpd.conf}/contents/log";
"error" = "syslog:user";
prefix "/software/components/metaconfig/services/{/etc/httpd/conf/httpd.conf}/contents/global";
"limitrequestfieldsize" = 8*1024*1024;

# ssl.conf
include 'common/httpd/config/ssl_conf';
