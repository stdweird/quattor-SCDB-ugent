unique template common/kibana/kibana3/config_ssl;

# config for kibana3 using httpd 
include 'common/httpd/service';

# build up vhosts in /tmp/httpd

# kibana config.js expects https on 443; so we will modify ssl.conf base vhost
include 'common/httpd/config/ssl_conf';

include 'common/kibana/kibana3/httpd';

include 'common/kibana/kibana3/elastichq';

# reassign 
"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents" = value("/tmp/httpd");
