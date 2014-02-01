unique template common/kibana/config_nss;

# config for kibana3 using httpd 
include 'common/httpd/service';

# build up vhosts in /tmp/httpd

# kibana config.js expects https on 443; so we will modify ssl.conf base vhost
include 'common/httpd/config/nss_conf';

"/tmp/httpd/listen" = null; # assuming the ssl.conf provides the listen
"/tmp/httpd/vhosts/base/port" = 443;

include 'common/kibana/httpd';

include 'common/kibana/elastichq';

# reassign 
"/software/components/metaconfig/services/{/etc/httpd/conf.d/nss.conf}/contents" = value("/tmp/httpd");
