unique template common/shorewall/service;

include { "common/shorewall/rpms/config" };

include { 'common/shorewall/config' };

# Start rsyncd
include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/shorewall/on" = "";
"/software/components/chkconfig/service/shorewall/startstop" = true;
